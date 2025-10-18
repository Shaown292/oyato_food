import 'package:get/get.dart';

import '../../cart/controllers/cart_controller.dart';
import '../../home/controllers/home_controller.dart';

class DashboardController extends GetxController {
  RxInt currentIndex = 0.obs;
  final cartController = Get.put(CartController());
  final  homeController = Get.put(HomeController());

  void changeTab(int index) {
    currentIndex.value = index;
  }

}
