import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:oyato_food/app/data/app_text_style.dart';
import 'package:oyato_food/app/payment_gateway/moneris_webview.dart';

class MonerisPreloadPage extends StatefulWidget {
  const MonerisPreloadPage({super.key});

  @override
  State<MonerisPreloadPage> createState() => _MonerisPreloadPageState();
}

class _MonerisPreloadPageState extends State<MonerisPreloadPage> {
  String responseText = "";
  String orderId = "";
  late double totalAmount;

  String generateOrderId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  Future<void> sendPreloadRequest() async {
    const String storeId = "monca10634";
    const String apiToken = "HtLtrrh9q0DX4mXhtf7u";
    const String checkoutId = "chkt6PRRP10634";
    const String environment = "qa";
    const String gatewayUrl =
        "https://gatewayt.moneris.com/chkt/request/request.php";

    final data = {
      "store_id": storeId,
      "api_token": apiToken,
      "checkout_id": checkoutId,
      "txn_total": totalAmount.toStringAsFixed(2),
      "environment": environment,
      "action": "preload",
      "order_no": orderId,
      "cust_id": "1234",
      "dynamic_descriptor": "dyndesc",
      "language": "en",
    };

    try {
      print("🧾 Sending preload for order: $orderId, amount: $totalAmount");
      final response = await http.post(
        Uri.parse(gatewayUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );

      print("Raw Response: ${response.body}");

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        if (decoded["response"]?["ticket"] != null) {
          final ticket = decoded["response"]["ticket"];
          debugPrint("✅ Ticket: $ticket");
          Get.to(
            () => MonerisCheckoutPage(
              checkoutId: ticket,
              total: totalAmount.toString(),
            ),
          );
        } else {
          debugPrint("⚠️ No ticket in response: ${response.body}");
        }
      } else {
        debugPrint("❌ Server error ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("⚠️ Exception: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    orderId = generateOrderId();
    totalAmount = Get.arguments ?? 0.0;

    if (totalAmount > 0) {
      sendPreloadRequest();
    } else {
      debugPrint("❌ totalAmount missing or zero.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Moneris Preload")),
      body: Center(
        child: Card(
          margin: EdgeInsets.all(16),
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Payment Summary", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 16),
                Text("Order ID: $orderId"),
                Text("Amount: \$${totalAmount.toStringAsFixed(2)}"),
                SizedBox(height: 24),
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text("Processing your payment...", style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ),
      )
      ,
    );
  }
}
