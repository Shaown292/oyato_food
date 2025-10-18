import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:oyato_food/app/data/app_colors.dart';
import 'package:oyato_food/app/routes/app_pages.dart';
import 'package:oyato_food/app/widgets/primary_button.dart';

import '../../../model/single_product_model.dart';
import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CartView'), centerTitle: true),
      body: Obx(() {
        if (controller.cartItems.isEmpty) {
          return const Center(child: Text("Cart is empty"));
        }
        return ListView.builder(
          itemCount: controller.cartItems.length,
          itemBuilder: (_, index) {
            final item = controller.cartItems[index];
            return Card(
              color: Colors.white.withOpacity(0.8),
              margin: EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 2,
              child: ListTile(
                leading: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(image: NetworkImage(controller.cartItems[index].image), fit: BoxFit.cover)
                  ),
                ),
                title: Text(controller.cartItems[index].title),
                subtitle: Text(
                  "\$${controller.cartItems[index].price} × 1 = \$${controller.cartItems[index].price}",
                ),
                trailing: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: FaIcon(FontAwesomeIcons.subtract, size: 16, color: AppColors.primaryColor,),
                          onPressed: () {
                            if(controller.cartItems[index].quantity > 1){
                              controller.decrementItem(
                                controller.cartItems[index].id,
                              );
                            }
                          },
                        ),
                        Text(item.quantity.toString()),
                        IconButton(
                          icon: FaIcon(FontAwesomeIcons.add, size: 16,color: AppColors.primaryColor),
                          onPressed: () {
                            controller.incrementItem(
                              controller.cartItems[index].id,
                            );
                          },
                        ),
                        IconButton(
                          icon: Container(
                            height: 25,
                            width: 25,
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red.withOpacity(0.9),
                            ),
                            child: Center(child: FaIcon(FontAwesomeIcons.remove,size: 16, color: Colors.white.withOpacity(0.8),)),
                          ),
                          onPressed: () {
                            controller.removeItem(
                              controller.cartItems[index].id,
                            );
                          },
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            );
          },
        );
      }),
      bottomNavigationBar: Obx(
        () => controller.cartItems.isEmpty
            ? SizedBox()
            : Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        "Total: ${controller.totalPrice.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: PrimaryButton(
                        width: MediaQuery.of(context).size.width * 0.6 - 10,
                        title: "Checkout",
                        onTap: () {
                          Get.toNamed(Routes.CHECKOUT);
                        },
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
