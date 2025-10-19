import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:oyato_food/app/data/app_colors.dart';
import 'package:oyato_food/app/data/app_text_style.dart';
import 'package:oyato_food/app/model/currated_category_model.dart';
import 'package:oyato_food/app/model/currated_product_model.dart';

import '../../../routes/app_pages.dart';
import '../controllers/currated_category_controller.dart';

class CurratedCategoryView extends GetView<CurratedCategoryController> {
  const CurratedCategoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // -------- Category List --------
        Obx(() => SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.categories.length,
            itemBuilder: (context, index) {
              final CurratedCategoryModel category =
              controller.categories[index];
              return Obx(() {
                final isSelected = controller.selectedCategoryId.value == category.id;

                return InkWell(
                  onTap: () {
                    controller.selectCategory(category);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      width: 110,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: isSelected ? AppColors.primaryColor.withOpacity(0.9) : Colors.grey[300],
                      ),
                      child: Center(
                        child: Text(
                          category.name,
                          style: AppTextStyle.textStyle14BlackBold
                        ),
                      ),
                    ),
                  ),
                );
              });
            },
          ),
        ),),

        const SizedBox(height: 10),

        // -------- Product List --------
        Obx(() {
          if (controller.selectedProducts.isEmpty) {
            return const Center(child: Text('No products found'));
          }

          return SizedBox(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.selectedProducts.length,
              itemBuilder: (context, index) {
                final CurratedProductModel product =
                controller.selectedProducts[index];

                return InkWell(
                  onTap: (){
                    Get.offNamed(
                      Routes.DETAIL_PAGE,
                      arguments: product.productId
                    );
                  },
                  child: Container(
                    width: 150,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 4,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                          child: Image.network(
                            product.image,
                            height: 100,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
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
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "৳ ${product.sellsPrice.isNotEmpty ? product.sellsPrice : product.regularPrice}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }),
      ],
    );
  }
}
