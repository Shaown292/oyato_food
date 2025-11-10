import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:oyato_food/app/api_service/api_repository.dart';

import '../../../global_controller/global_controller.dart';


class PaymentController extends GetxController {
  var isLoading = false.obs;
  var ticketNumber = "".obs;
  var paymentResponse = {}.obs;
  RxString errorMessage = "".obs;
  final ApiRepository _repository = ApiRepository();
  GlobalController globalController = Get.find<GlobalController>();




  // Hosted payment URL
  String paymentUrl = "https://www.moneris.com/";



  // Call backend API with ticketNumber

  Future<bool> cardPayment({required String amount, required String ticket}) async {
    try {
      print("Entering");
      isLoading(true);
      errorMessage('');
       await _repository.cardPay(amount: amount, ticket: ticket);
      print("CardPayment Called");

      return true;
    } catch (e) {
      errorMessage.value = e.toString();
      return false;
    } finally {
      isLoading(false);
    }
  }


  Future<bool> sendBillPayRequest(String token, String amount) async {
    const String url = "https://oyatofood.com/api/order.php"; // Replace with your endpoint
    print("1 $token $amount");
    Map<String, dynamic> body = {
      "order": "bill-pay",
      "userid": globalController.userId.value,
      "method": "2",
      "pay-card":"true",
      "pay-amount" : amount,
      "ticketNumber" : token,
      "gettoken": "0123456789"
    };

    try {
      print("2 $token ${globalController.userId.value}");
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        print("3");
        final data = jsonDecode(response.body);

        // Adjust condition according to your API response format
        if (data["status"] == "success" ) {
          print("4");
          return true;
        }
      }
      print("5 responseb${response.statusCode}  body${response.body}");
      return false;
    } catch (e,stack) {
      print("6 $e");
      print("❌ Exception: $e");
      print("🧵 Stack Trace: $stack");
      return false; // In case of any error
    }
  }


}
