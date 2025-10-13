import 'package:get/get.dart';

import '../../cart/controllers/cart_controller.dart';

class DashboardController extends GetxController {
  RxInt currentIndex = 0.obs;
  final cartController = Get.put(CartController());

  void changeTab(int index) {
    currentIndex.value = index;
  }

}
