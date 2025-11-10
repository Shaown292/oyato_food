import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oyato_food/app/data/app_text_style.dart';
import 'package:oyato_food/app/model/all_product_model.dart';
import 'package:oyato_food/app/model/banner_model.dart';
import 'package:oyato_food/app/model/best_selling_product.dart';
import 'package:oyato_food/app/modules/currated_category/bindings/currated_category_binding.dart';
import 'package:oyato_food/app/modules/currated_category/views/currated_category_view.dart';
import 'package:oyato_food/app/routes/app_pages.dart';
import 'package:oyato_food/app/widgets/custom_carousel_slider.dart';

class HomeWidget extends StatelessWidget {
  final List<AllProductData>? productData;
  final List<BannerModel>? bannerData;
  final List<BestSellingProduct>? bestData;
  final List<BestSellingProduct>? mustHaveData;
  final List<BestSellingProduct>? popularCategoryData;
  final String? categoryId;
  const HomeWidget({
    super.key,
    required this.productData,
    required this.bannerData,
    required this.bestData,
    required this.mustHaveData,
    required this.popularCategoryData,
    this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    // Make sure the controller is initialized
    CurratedCategoryBinding().dependencies();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomCarouselSlider(sliderData: bannerData ?? []),

              const SizedBox(height: 25),

              /// Best Selling
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Best Selling Product",
                      style: AppTextStyle.textStyle18BlackBold,
                    ),
                    SizedBox(height: 10),
                    // Horizontal Product List
                    Obx(
                      () => SizedBox(
                        height: 190,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: bestData!.length,
                          itemBuilder: (context, index) {
                            final product = bestData![index];
                            return InkWell(
                              onTap: () {
                                Get.offNamed(
                                  Routes.DETAIL_PAGE,
                                  arguments: bestData![index].productID
                                      .toString(),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 140,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 5,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                const BorderRadius.vertical(
                                                  top: Radius.circular(12),
                                                ),
                                            child: Image.network(
                                              product.image,
                                              height: 120,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0,
                                              vertical: 2,
                                            ),
                                            child: Text(
                                              product.title,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 5,
                                            ),
                                            child: Text(
                                              product.regularPrice,
                                              style: const TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),

              /// Popular Category
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Popular Category",
                      style: AppTextStyle.textStyle18BlackBold,
                    ),
                    SizedBox(height: 10),
                    // Horizontal Product List
                    Obx(
                      () => SizedBox(
                        height: 180,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: popularCategoryData!.length,
                          itemBuilder: (context, index) {
                            final product = popularCategoryData![index];
                            return InkWell(
                              onTap: () {
                                Get.toNamed(
                                  Routes.SEARCH,
                                  arguments: popularCategoryData![index]
                                      .categoryId
                                      .toString(),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 180,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 5,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                const BorderRadius.vertical(
                                                  top: Radius.circular(12),
                                                ),
                                            child: Image.network(
                                              product.productImage,
                                              height: 120,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0,
                                              vertical: 5,
                                            ),
                                            child: Text(
                                              product.categoryName,
                                              style: AppTextStyle
                                                  .textStyle18BlackBold,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              ///CurratedCategoryView
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8),
                child: Text(
                  "Currated Product",
                  style: AppTextStyle.textStyle18BlackBold,
                ),
              ),
              CurratedCategoryView(),
              //// Must Have
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Must Have Product",
                      style: AppTextStyle.textStyle18BlackBold,
                    ),
                    SizedBox(height: 10),
                    // Horizontal Product List
                    Obx(
                      () => SizedBox(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: mustHaveData!.length,
                          itemBuilder: (context, index) {
                            final product = mustHaveData![index];
                            return InkWell(
                              onTap: () {
                                Get.offNamed(
                                  Routes.DETAIL_PAGE,
                                  arguments: mustHaveData![index].productID
                                      .toString(),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: Column(
                                  children: [
                                    Container(
                                      width: 140,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 5,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                const BorderRadius.vertical(
                                                  top: Radius.circular(12),
                                                ),
                                            child: Image.network(
                                              product.image,
                                              height: 120,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0,
                                              vertical: 2,
                                            ),
                                            child: Text(
                                              product.title,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 8,
                                              vertical: 5,
                                            ),
                                            child: Text(
                                              product.regularPrice,
                                              style: const TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),

              /// New Arrivals
              Text("All Product 🔥", style: AppTextStyle.textStyle18BlackBold),

              const SizedBox(height: 15),

              /// Product List
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: productData!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  final product = productData![index];
                  return InkWell(
                    onTap: () {
                      Get.offNamed(
                        Routes.DETAIL_PAGE,
                        arguments: productData![index].productID.toString(),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.grey.shade100,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                ),
                                child: Image.network(
                                  product.image ?? "",
                                  height: 140,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.title ?? "",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  product.shortDescription ?? "",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  product.regularPrice ?? "",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
