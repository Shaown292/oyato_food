import 'package:get/get.dart';
import 'package:oyato_food/app/api_service/api_repository.dart';


class PaymentController extends GetxController {
  var isLoading = false.obs;
  var ticketNumber = "".obs;
  var paymentResponse = {}.obs;
  RxString errorMessage = "".obs;
  final ApiRepository _repository = ApiRepository();


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

}
