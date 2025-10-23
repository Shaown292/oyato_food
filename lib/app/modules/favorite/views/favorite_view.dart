import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:oyato_food/app/data/app_text_style.dart';
import 'package:oyato_food/app/widgets/custom_text_field.dart';

import '../../home/widgets/home_widget.dart';
import '../controllers/favorite_controller.dart';

class FavoriteView extends GetView<FavoriteController> {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Favorite', style: AppTextStyle.textStyle18BlackBold),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: FaIcon(FontAwesomeIcons.bell, color: Colors.black87),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: CustomTextFormField(
              prefixIcon: Padding(
                padding: const EdgeInsets.all(10.0),
                child: FaIcon(
                  FontAwesomeIcons.search,
                  size: 25,
                  color: Colors.black54,
                ),
              ),
              hintText: "Search Something...",
              hintTextStyle: AppTextStyle.textStyle14GreyW500,
            ),
          ),
          SizedBox(height: 20),
          Obx(
            () =>controller.isLoading.value
                ? CircularProgressIndicator() : Expanded(
              child: GridView.builder(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
                shrinkWrap: true,
                itemCount: controller.wishList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.7,
                ),
                itemBuilder: (context, index) {
                  final product = controller.wishList[index];
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.grey.shade100,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              ),
                              child: Image.network(
                                product.image,
                                height: 150,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    height: 150,
                                    width: MediaQuery.of(context).size.width * 0.85,
                                    color: Colors.grey[300],
                                    child: Icon(Icons.broken_image, color: Colors.grey),
                                  );
                                },
                              ),
                            ),
                            InkWell(
                              onTap:(){
                                controller.deleteFromWishlist(productId: product.productId);
                                controller.fetchWishlistItems();
                              },
                              child: Positioned(
                                top: 10,
                                right: 10,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: FaIcon(
                                    FontAwesomeIcons.solidHeart,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                product.regularPrice,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                product.sellsPrice.toString(),
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
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
