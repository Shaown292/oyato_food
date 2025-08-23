import 'package:get/get.dart';

import '../../cart/controllers/cart_controller.dart';
import '../../favorite/controllers/favorite_controller.dart';
import '../../home/controllers/home_controller.dart';
import '../../profile/controllers/profile_controller.dart';
import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DashboardController());
    Get.put(HomeController());
    Get.put(FavoriteController());
    Get.put(CartController());
    Get.put(ProfileController());
  }
}
