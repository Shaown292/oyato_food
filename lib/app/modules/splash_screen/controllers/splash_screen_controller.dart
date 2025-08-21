import 'package:get/get.dart';
import 'package:oyato_food/app/modules/dashboard/views/dashboard_view.dart';
import 'package:oyato_food/app/modules/log_in/views/log_in_view.dart';
import 'package:oyato_food/app/routes/app_pages.dart';

class SplashScreenController extends GetxController {
  //TODO: Implement SplashScreenController

  final count = 0.obs;
  @override
  void onInit() {
    print("Created");
    super.onInit();
    Future.delayed(const Duration(seconds: 3), () {
      Get.off(() => LogInView());
      // Get.toNamed(Routes.DASHBOARD); // replace splash with HomePage
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
