import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:oyato_food/app/data/app_colors.dart';
import 'package:oyato_food/app/modules/cart/views/cart_view.dart';
import '../../favorite/views/favorite_view.dart';
import '../../home/views/home_view.dart';
import '../../profile/views/profile_view.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});
  @override
  Widget build(BuildContext context) {

    final pages = [
    const HomeView(),
    const FavoriteView(),
     const CartView(),
      const ProfileView(),
    ];
    return   Obx(() => Scaffold(
      body: pages[controller.currentIndex.value],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: controller.currentIndex.value,
        onTap: controller.changeTab,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: Colors.grey[500],
        items: const [
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.house), label: "Home"),
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.heart), label: "Favorite"),
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.cartPlus), label: "Cart"),
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.user), label: "Profile"),
        ],
      ),
    ));
  }
}
