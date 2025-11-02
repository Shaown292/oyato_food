import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:oyato_food/app/api_service/api_repository.dart';
import 'dart:convert';

import 'package:oyato_food/app/global_controller/global_controller.dart';

class PaymentController extends GetxController {
  var isLoading = false.obs;
  var ticketNumber = "".obs;
  var paymentResponse = {}.obs;
  RxString errorMessage = "".obs;
  final ApiRepository _repository = ApiRepository();


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

  Future<bool> cardPayment({required String amount, required String ticket}) async {
    try {
      isLoading(true);
      errorMessage('');
      final card = await _repository.cardPay(amount: amount, ticket: ticket);
      print("CardPayment Called");
      return true;
    } catch (e) {
      errorMessage.value = e.toString();
      return false;
    } finally {
      isLoading(false);
    }
  }

}
