import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:oyato_food/app/routes/app_pages.dart';
import 'dart:convert';
import '../modules/payment/controllers/payment_controller.dart';

class MonerisCheckoutPage extends StatefulWidget {
  final String ticket;
  final String total;
  const MonerisCheckoutPage({required this.ticket, required this.total});

  @override
  _MonerisCheckoutPageState createState() => _MonerisCheckoutPageState();
}

class _MonerisCheckoutPageState extends State<MonerisCheckoutPage> {

  late InAppWebViewController _controller;
  @override
  Widget build(BuildContext context) {
    print("Tciket ${widget.ticket}");
    final html = '''<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
  <style>
    body, html {
      height: 100%;       /* Full height of the viewport */
      margin: 0;          /* Remove default margins */
      display: flex;      /* Flexbox for centering */
      justify-content: center; /* Center horizontally */
      align-items: center; /* Center vertically */
      overflow: hidden;    /* Prevent scrollbars */
      background-color: #f0f0f0; /* Light background */
    }

    #monerisCheckout {
      width: 100%;        /* Full width on mobile */
      height: 100%;       /* Full height on mobile */
      max-width: 600px;   /* Constrain width for larger screens */
      max-height: 80vh;   /* Limit height to 80% of viewport height */
      transform: scale(1.0); /* Default scale for mobile, no zoom */
      transform-origin: center center; /* Zoom from center if needed */
      box-shadow: 0 4px 8px rgba(0,0,0,0.1); /* Subtle shadow */
      border-radius: 8px; /* Rounded corners */
    }

    /* Media query for mobile devices */
    @media screen and (max-width: 768px) {
      #monerisCheckout {
        max-width: 90vw;  /* 90% of viewport width for smaller screens */
        max-height: 90vh; /* 90% of viewport height for smaller screens */
        transform: scale(1.0); /* Ensure no zoom on small screens */
      }
    }
  </style>
</head>
<body>
  <div id="monerisCheckout">Loading...</div>

  <script src="https://gatewayt.moneris.com/chkt/js/chkt_v1.00.js"></script>
  <script>
    function setupCheckout() {
      var myCheckout = new monerisCheckout();
      myCheckout.setMode("qa"); // Or "qa" for testing
      myCheckout.setCheckoutDiv("monerisCheckout");

      myCheckout.setCallback("payment_complete", function(e) {
        window.flutter_inappwebview.callHandler('payment_complete', e);
      });

      myCheckout.setCallback("error_event", function(e) {
        window.flutter_inappwebview.callHandler('payment_error', e);
      });

      myCheckout.startCheckout("${widget.ticket}"); 
    }

    if (window.flutter_inappwebview) {
      setupCheckout();
    } else {
      document.addEventListener('flutterInAppWebViewPlatformReady', setupCheckout);
    }
  </script>
</body>
</html>

''';

    return WillPopScope     (
      onWillPop: () async => false,
      child: Scaffold(
        body: InAppWebView(
          initialData: InAppWebViewInitialData(data: html),
          onWebViewCreated: (controller) {
            _controller = controller;

            controller.addJavaScriptHandler(
              handlerName: "paymentSuccess",
              callback: (args) {
                final receipt = jsonEncode(args[0]);
                print("✅ Payment Success: $receipt");

                Navigator.pop(context, receipt);
              },
            );
          },
        ),
      ),
    );
  }

  void _handlePaymentComplete(List<dynamic> args) {
    print('🔍 payment_complete args: $args');
    if (args.isNotEmpty) {
      try {
        final data = args.first is String ? jsonDecode(args.first) : args.first;
        if (data is Map) {
          final ticket = data['ticket'];
          final responseCode = data['response_code'];
          print("✅ Payment completed successfully.");
          print("🎫 Ticket: $ticket");
          print("📄 Response Code: $responseCode");
          _handlePostPayment(ticket, responseCode);
        } else {
          print("⚠️ Unexpected payment data format: $args");
        }
      } catch (e) {
        print("❌ Error parsing payment data: $e");
        print("⚠️ Raw args: $args");
      }
    } else {
      print("⚠️ No payment data received: $args");
    }
  }

  void _handlePostPayment(String ticket, String responseCode) async {
    final PaymentController paymentController = Get.put(PaymentController());

    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    final bool paymentSuccessful =  await paymentController.cardPayment(
      amount: widget.total,
      ticket: ticket,
    );

    // Remove loading dialog
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }

    if (!mounted) return;

    if (paymentSuccessful) {
      // final String? orderId = paymentController.orderId;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('✅ Order Successful'),
            content: Text('Your order has been placed successfully!\n\n🧾 Order ID: '),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Get.offNamed(Routes.DASHBOARD);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("❌ Payment Failed"),
          content: Text("Unbale to place order"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }


}


