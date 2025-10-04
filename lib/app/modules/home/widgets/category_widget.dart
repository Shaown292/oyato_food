import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:oyato_food/app/data/app_text_style.dart';
import 'package:oyato_food/app/model/category_model.dart';
import 'package:oyato_food/app/routes/app_pages.dart';

class CategoryWidget extends StatelessWidget {
  final List<Category> categoryData;
  const CategoryWidget({super.key, required this.categoryData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: ListView.builder(
        itemCount: categoryData.length, // number of items
        itemBuilder: (context, index) {
          final List<Subcategory> subList = categoryData[index].subcategories;
          return InkWell(
            onTap: () => subList.isEmpty ? Get.snackbar("Sorry", "No product available"): Get.toNamed(Routes.CATEGORY_PRODUCT, arguments: subList),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[400],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(categoryData[index].name.toString(), style: AppTextStyle.textStyle18BlackBold,),
                          Text("${categoryData[index].totalProduct.toString()} Products", style: AppTextStyle.textStyle14BlackBold,),
                        ],
                      ),
                    ),
                    Container(
                      width: 180,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topRight:Radius.circular(10),bottomRight:Radius.circular(10),),
                        image: DecorationImage(image: NetworkImage(categoryData[index].logo.toString()), fit: BoxFit.cover)
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
