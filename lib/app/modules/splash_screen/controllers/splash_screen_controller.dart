import 'package:get/get.dart';
import 'package:oyato_food/app/global_controller/global_controller.dart';
import 'package:oyato_food/app/modules/log_in/views/log_in_view.dart';
import 'package:oyato_food/app/routes/app_pages.dart';

class SplashScreenController extends GetxController {

  GlobalController globalController = Get.find<GlobalController>();
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 3), () {
      globalController.userId.isEmpty ? Get.offNamed(Routes.LOG_IN) : Get.offNamed(Routes.DASHBOARD);

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
