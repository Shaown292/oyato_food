import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:oyato_food/app/global_controller/global_controller.dart';
import 'package:oyato_food/app/routes/app_pages.dart';

class SplashScreenController extends GetxController {

  GlobalController globalController = Get.find<GlobalController>();
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onReady() {
    super.onReady();
    _checkLogin();
  }

  Future<void> _checkLogin() async {
    await Future.delayed(const Duration(seconds: 2));

    if (_auth.currentUser != null || globalController.userId.isNotEmpty) {
        Get.offNamed(Routes.DASHBOARD);
    } else {
      Get.offAllNamed(Routes.LOG_IN);
    }
  }
}
