import 'package:flutter/material.dart';

import 'package:get/get.dart';
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
            return ListTile(
              leading: Image.network(controller.cartItems[index].image, width: 60),
              title: Text(controller.cartItems[index].title),
              subtitle: Text(
                "\$${controller.cartItems[index].price} × 1 = \$${controller.cartItems[index].price}",
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: () {
                       controller.decrementItem(controller.cartItems[index].id) ;
                    },
                  ),
                  Text(item.quantity.toString()),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: () {
                      controller.incrementItem(controller.cartItems[index].id);
                    },
                  ),
                ],
              ),
            );
          },
        );
      }),
      bottomNavigationBar: Obx(
        () => controller.cartItems.isEmpty ? SizedBox() : Padding(
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
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: PrimaryButton( width: MediaQuery.of(context).size.width * 0.6 - 10,title: "Checkout", onTap: (){
                  Get.toNamed(Routes.CHECKOUT);
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
