import 'package:get/get.dart';
import 'package:oyato_food/app/modules/discount/controllers/discount_controller.dart';

import '../../cart/controllers/cart_controller.dart';
import '../../favorite/controllers/favorite_controller.dart';
import '../../home/controllers/home_controller.dart';
import '../../profile/controllers/profile_controller.dart';
import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DashboardController());
    Get.put(FavoriteController());
    Get.put(DiscountController());
    Get.put(ProfileController());
  }
}
