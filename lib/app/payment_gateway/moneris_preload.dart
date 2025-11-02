import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:oyato_food/app/payment_gateway/moneris_webview.dart';

class MonerisPreloadPage extends StatefulWidget {
  const MonerisPreloadPage({super.key});

  @override
  State<MonerisPreloadPage> createState() => _MonerisPreloadPageState();
}

class _MonerisPreloadPageState extends State<MonerisPreloadPage> {
  final TextEditingController _amountController = TextEditingController();

  String responseText = "";

  Future<void> sendPreloadRequest() async {
    const String storeId = "monca10634";
    const String apiToken = "HtLtrrh9q0DX4mXhtf7u";
    const String checkoutId = "chkt6PRRP10634";
    const String environment = "qa"; // "prod" for live
    const String gatewayUrl =
        "https://gatewayt.moneris.com/chkt/request/request.php";

    final double? amount = double.tryParse(_amountController.text);
    if (amount == null || amount <= 0) {
      setState(() {
        responseText = "❌ Invalid amount entered.";
      });
      return;
    }

    final data = {
      "store_id": storeId,
      "api_token": apiToken,
      "checkout_id": checkoutId,
      "txn_total": amount.toStringAsFixed(2),
      "environment": environment,
      "action": "preload",
      "order_no": DateTime.now().millisecondsSinceEpoch.toString(),
      "cust_id": "1234",
      "dynamic_descriptor": "dyndesc",
      "language": "en",
    };

    try {
      final response = await http.post(
        Uri.parse(gatewayUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        setState(() {
          responseText = const JsonEncoder.withIndent('  ').convert(decoded);
        });

        if (decoded["response"]?["ticket"] != null) {
          final ticket = decoded["response"]["ticket"];
          debugPrint("✅ Ticket: $ticket");
          Get.to(()=> MonerisCheckoutPage(ticket: ticket, total: "30"));
          // এখন তুমি চাইলে এই ticket দিয়ে Moneris Checkout WebView খুলে দিতে পারো।
        } else {
          debugPrint("⚠️ No ticket in response");
        }
      } else {
        setState(() {
          responseText =
          "❌ Error: Server returned ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        responseText = "⚠️ Exception: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Moneris Preload (Direct)")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: "Enter Amount (CAD)",
                border: OutlineInputBorder(),
              ),
              keyboardType:
              const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: sendPreloadRequest,
              child: const Text("Send Preload Request"),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  responseText,
                  style: const TextStyle(fontFamily: "monospace"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}