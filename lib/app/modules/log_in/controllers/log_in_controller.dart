import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:oyato_food/app/api_service/api_provider.dart';
import 'package:oyato_food/app/global_controller/global_controller.dart';
import 'package:oyato_food/app/routes/app_pages.dart';

class LogInController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final ApiProvider _apiProvider = ApiProvider();
  GlobalController globalController = Get.find<GlobalController>();

  RxBool isLoading = false.obs;
  RxString responseData = "".obs;
  RxString errorMessage = "".obs;

  RxString status = ''.obs;



  Future<void> login({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse("${_apiProvider.baseUrl}/api/user-auth.php"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
          "signin-type": "100",
          "gettoken": "0123456789",
          "login-user": "true"

        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final  Map<String, dynamic> data = jsonDecode(response.body);
        status.value = data["status"] ?? '';

        if( status.value  == "success" ){
          print(const JsonEncoder.withIndent('  ').convert(data));
          globalController.setValue(data["response"]["userid"]);
          print("UserId : ${globalController.userId}");
          emailController.clear();  print(const JsonEncoder.withIndent('  ').convert(data));
          globalController.setValue(data["response"]["userid"]);
          print("UserId : ${globalController.userId}");
          emailController.clear();
          Get.offNamed(Routes.DASHBOARD);
          passwordController.clear();

          
        }
        debugPrint(status.value);
        Get.snackbar(status.value, data["response"]["message"]);
      } else {
        final error = jsonDecode(response.body);
        Get.snackbar("Error", error["message"] ?? "Something went wrong");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
