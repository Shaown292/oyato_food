import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:oyato_food/app/data/app_colors.dart';
import 'package:oyato_food/app/data/app_text_style.dart';
import 'package:oyato_food/app/modules/home/widgets/category_widget.dart';
import 'package:oyato_food/app/modules/home/widgets/home_widget.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: EdgeInsets.only(left: 10),
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage("https://i.pravatar.cc/150?img=3"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hi, Jonathan", style: AppTextStyle.textStyle14BlackBold),
            Text("Let's go shopping", style: AppTextStyle.textStyle14GreyW500),
          ],
        ),
        actions: [
          FaIcon(FontAwesomeIcons.search, color: AppColors.primaryColor),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 20),
            child: FaIcon(FontAwesomeIcons.bell, color: AppColors.primaryColor),
          ),
        ],
        bottom: TabBar(
          controller: controller.tabController,
          labelColor: AppColors.primaryColor,
          unselectedLabelColor: Colors.grey,
          indicatorColor: AppColors.primaryColor,
          tabs: const [
            Tab(text: "Home"),
            Tab(text: "Category"),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller.tabController,
        children: [
          Obx(() {
            return controller.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryColor,
                    ),
                  )
                : controller.allProductData.isEmpty
                ? Center(child: Text("Check your internet"))
                : HomeWidget(
                    productData: controller.allProductData,
                    bannerData: controller.banners,
                  );
          }),
          Obx(() {
            if (controller.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor),
              );
            }
            if (controller.categories.isEmpty) {
              return const Center(child: Text("No Data"));
            }
            return CategoryWidget(categoryData: controller.categories);
          }),
        ],
      ),
    );
  }
}
