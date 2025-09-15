import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:oyato_food/app/data/api_service.dart';
import 'package:oyato_food/app/routes/app_pages.dart';

class LogInController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final ApiService _apiService = ApiService();

  var isLoading = false.obs;
  var responseData = "".obs;
  var errorMessage = "".obs;

  var status = ''.obs;



  Future<void> login({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse("${_apiService.baseUrl}/api/user-auth.php"),
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
        final data = jsonDecode(response.body);
        status.value = data["status"] ?? '';

        if( status.value  == "success" ){
          emailController.clear();
          passwordController.clear();
          Get.toNamed(Routes.DASHBOARD);
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
