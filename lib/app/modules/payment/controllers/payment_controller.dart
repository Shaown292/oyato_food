import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PaymentController extends GetxController {
  var isLoading = false.obs;
  var ticketNumber = "".obs;
  var paymentResponse = {}.obs;

  // Hosted payment URL
  String paymentUrl = "https://www.moneris.com/";

  // Called when WebView returns ticketNumber
  void onPaymentCompleted(String token) {
    ticketNumber.value = token;
    sendTicketToBackend(token);
  }

  // Call backend API with ticketNumber
  Future<void> sendTicketToBackend(String ticket) async {
    isLoading.value = true;

    final payload = {
      "order": "bill-pay",
      "userid": "32652154847",
      "method": "2",
      "pay-card": "true",
      "pay-amount": "3.49",
      "ticketNumber": ticket,
      "gettoken": "123321",
    };

    try {
      final response = await http.post(
        Uri.parse("https://yourbackend.com/api/payment"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200) {
        paymentResponse.value = jsonDecode(response.body);
        Get.snackbar("Success", "Payment completed successfully");
      } else {
        Get.snackbar("Error", "Payment failed: ${response.body}");
      }
    } catch (e) {
      Get.snackbar("Error", "Payment error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
