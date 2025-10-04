import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:oyato_food/app/data/app_colors.dart';
import 'package:oyato_food/app/data/app_text_style.dart';

import '../controllers/detail_page_controller.dart';

class DetailPageView extends GetView<DetailPageController> {
  const DetailPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Details Page", style: AppTextStyle.textStyle14BlackBold),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: FaIcon(
              FontAwesomeIcons.cartShopping,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }
          if (controller.errorMessage.isNotEmpty) {
            return Center(child: Text("❌ ${controller.errorMessage.value}"));
          }
          if (controller.products.isEmpty) {
            return Center(child: Text("⚠️ No products found"));
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                Obx(() {
                  if (controller.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (controller.errorMessage.isNotEmpty) {
                    return Center(child: Text("❌ ${controller.errorMessage.value}"));
                  }
                  if (controller.products.isEmpty) {
                    return Center(child: Text("⚠️ No products found"));
                  }
                  return  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        // Top Section with Image
                        Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.6,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(controller.products[0].image),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            // Expanded(child: SizedBox()),
                          ],
                        ),

                        Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(top: Radius.circular(50)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 10,
                                offset: Offset(0, -3),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Title + Quantity
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        controller.products[0].title,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Obx(
                                            () => Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                if (controller.quantity > 1) {
                                                  controller.total.value =
                                                      controller.price.value *
                                                          controller.quantity.value;
                                                  controller.quantity--;
                                                }
                                              },
                                              icon: const Icon(
                                                Icons.remove_circle_outline,
                                              ),
                                            ),
                                            Text(
                                              controller.quantity.toString(),
                                              style: TextStyle(fontSize: 16),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                controller.quantity++;
                                                controller.total.value =
                                                    controller.price.value *
                                                        controller.quantity.value;
                                                debugPrint(
                                                  "price ${controller.price.value}, Q: ${controller.quantity.value}",
                                                );
                                              },
                                              icon: const Icon(Icons.add_circle_outline),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                                  // Rating + Stock
                                  Row(
                                    children: const [
                                      Icon(Icons.star, color: Colors.amber, size: 18),
                                      SizedBox(width: 4),
                                      Text("4.8 (320 Review)"),
                                      Spacer(),
                                      Text(
                                        "Available in stock",
                                        style: TextStyle(color: Colors.green),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),

                                  // Description
                                  const Text(
                                    "Description",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    // constraints: BoxConstraints(maxHeight: 100),
                                    child: Text(
                                      controller.products[0].description,
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                  ),
                                  const SizedBox(height: 20),

                                  // Price + Add to Cart
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "\$"
                                        "${controller.quantity.value == 1 ? controller.price.value.toStringAsPrecision(4) : controller.total.value.toStringAsPrecision(4)}",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  ElevatedButton.icon(
                                    onPressed: () {},
                                    icon: const Icon(Icons.shopping_cart_outlined),
                                    label: const Text("Add to Cart"),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.deepPurple,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 14,
                                        horizontal: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),


                      ],
                    ),
                  );
                }),
                SizedBox(height: 20,),
                Obx(() {
                  if (controller.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (controller.errorMessage.isNotEmpty) {
                    return Center(child: Text("❌ ${controller.errorMessage.value}"));
                  }
                  if (controller.relatedProducts.isEmpty) {
                    return Center(child: Text("⚠️ No related products found", style: AppTextStyle.textStyle14BlackBold,));
                  }
                  return   SizedBox(
                    height: 250, // give it a fixed height
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal, // set horizontal scrolling
                      itemCount: controller.relatedProducts.length, // number of items
                      itemBuilder: (context, index) {
                        return Container(
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
                                    topRight: Radius.circular(16)),
                                child: Image.network(
                                  controller.relatedProducts[index].image,
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      height: 150,
                                      width: 200,
                                      color: Colors.grey[300],
                                      child: Icon(Icons.broken_image, color: Colors.grey),
                                    );
                                  },
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: [
                                  Text(  controller.relatedProducts[index].title,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text( controller.relatedProducts[index].regularPrice,
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.grey)),
                                  const SizedBox(height: 5),
                                  Text(controller.relatedProducts[index].sellsPrice,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ],
                          ),
                        );
                      }, separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(width: 10,);
                    },
                    ),
                  );
                }),



              ],
            ),
          );
        }),
      ),
    );
  }
}
