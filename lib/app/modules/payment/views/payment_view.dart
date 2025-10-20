import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../controllers/payment_controller.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({super.key});

  @override
  _PaymentViewState createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  final PaymentController controller = Get.find<PaymentController>();
  late final WebViewController webController;

  @override
  void initState() {
    super.initState();

    // Initialize WebViewController (no more WebView.platform for 4.x)
    webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) {
            // Intercept success URL
            if (request.url.contains("payment-success")) {
              Uri uri = Uri.parse(request.url);
              String? token = uri.queryParameters['token'];
              if (token != null) {
                Get.back(); // Close WebView
                controller.onPaymentCompleted(token);
              }
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      );
  }

  void openWebView() {
    webController.loadRequest(Uri.parse(controller.paymentUrl));
    Get.to(() => WebViewScreen(
      url: controller.paymentUrl,
      onPaymentCompleted: (token) => controller.onPaymentCompleted(token),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Payment")),
      body: Obx(() => Stack(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: openWebView,
              child: Text("Pay Now"),
            ),
          ),
          if (controller.isLoading.value)
            Center(child: CircularProgressIndicator()),
          if (controller.paymentResponse.isNotEmpty)
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Text(
                "Response: ${controller.paymentResponse}",
                style: TextStyle(color: Colors.green),
              ),
            ),
        ],
      )),
    );
  }
}

// WebView Screen
class WebViewScreen extends StatefulWidget {
  final String url;
  final Function(String token) onPaymentCompleted;

  WebViewScreen({required this.url, required this.onPaymentCompleted});

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController webController;

  @override
  void initState() {
    super.initState();
    webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) {
            if (request.url.contains("payment-success")) {
              Uri uri = Uri.parse(request.url);
              String? token = uri.queryParameters['token'];
              if (token != null) {
                widget.onPaymentCompleted(token);
                Navigator.of(context).pop();
              }
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url)); // Load AFTER controller is ready
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Complete Payment")),
      body: WebViewWidget(controller: webController),
    );
  }
}
