import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:oyato_food/app/data/app_colors.dart';
import 'package:oyato_food/app/data/app_text_style.dart';
import 'package:oyato_food/app/modules/payment/views/payment_view.dart';
import 'package:oyato_food/app/payment_gateway/moneris_webview.dart';
import 'package:oyato_food/app/routes/app_pages.dart';
import 'package:oyato_food/app/widgets/custom_text_field.dart';
import 'package:oyato_food/app/widgets/primary_button.dart';

import '../controllers/checkout_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  const CheckoutView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CheckoutView'), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.cartController.cartItems.length,
                  itemBuilder: (context, index) {
                    final item = controller.cartController.cartItems[index];
                    return Card(
                      color: Colors.white.withOpacity(0.8),
                      margin: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 2,
                      child: ListTile(
                        leading: Image.network(item.image, width: 60),
                        title: Text(item.title),
                        subtitle: Text('Quantity: ${item.quantity}'),
                        trailing: Text(
                          '\$${(item.price * item.quantity).toStringAsFixed(2)}',
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Select Delivery Option",
                style: AppTextStyle.textStyle18BlackBold,
              ),
              SizedBox(height: 20),

              /// Select Delivery Option
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: controller.deliveryOptions.map((option) {
                    bool isSelected =
                        controller.selectedDeliveryOption.value == option["id"];
                    return GestureDetector(
                      onTap: () => controller.selectDeliveryOption(
                        option["id"] as String,
                      ),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        padding: EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 16,
                        ),
                        width: 150,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.blue.shade50
                              : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected
                                ? Colors.blue
                                : Colors.grey.shade300,
                            width: isSelected ? 2 : 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              backgroundColor: option["color"] as Color,
                              radius: 25,
                              child: FaIcon(
                                option["icon"] as IconData,
                                size: 28,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 12),
                            Text(
                              option["title"] as String,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Radio<String>(
                              value: option["id"] as String,
                              groupValue:
                                  controller.selectedDeliveryOption.value,
                              onChanged: (value) {
                                if (value != null) {
                                  controller.selectDeliveryOption(value);
                                }
                              },
                              activeColor: Colors.blue,
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 20),
              Text("Review Address", style: AppTextStyle.textStyle18BlackBold),
              SizedBox(height: 10),
              /// Store Location
              Obx(
                () => DropdownButtonFormField<String>(
                  isExpanded: true,
                  value: controller.selectedAddress.value.isEmpty
                      ? null
                      : controller.selectedAddress.value,
                  hint: const Text(
                    'Select the store location',
                  ), // 👈 shown as label initially
                  decoration: InputDecoration(
                    labelText: "Pickup Store (used if you choose Pickup)",
                    labelStyle: AppTextStyle.textStyle14GreyW500,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: AppColors.primaryColor,
                        width: 1.5,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: AppColors.primaryColor,
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: AppColors.primaryColor,
                        width: 1,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: controller.shopLocation
                      .map(
                        (address) => DropdownMenuItem(
                          value: address,
                          child: Text(address, overflow: TextOverflow.ellipsis),
                        ),
                      )
                      .toList(),
                  onChanged: (val) {
                    if (val != null) controller.selectedAddress.value = val;
                  },
                ),
              ),
              SizedBox(height: 10),
              CustomTextFormField(
                controller: controller.searchAddressController,
                prefixIcon: Icon(
                  Icons.search,
                  size: 30,
                  color: AppColors.primaryColor,
                ),
                hintText: "Search your area",
              ),
              SizedBox(height: 20),
              CustomTextFormField(
                controller: controller.emailController,
                hintText: "Enter your mail",
              ),
              SizedBox(height: 20),
              CustomTextFormField(
                controller: controller.firstNameController,
                hintText: "First name",
              ),
              SizedBox(height: 20),
              CustomTextFormField(
                controller: controller.lastNameController,
                hintText: "Last name",
              ),
              SizedBox(height: 20),
              CustomTextFormField(
                controller: controller.streetController,
                hintText: "Street",
              ),
              SizedBox(height: 20),
              CustomTextFormField(
                controller: controller.cityController,
                hintText: "City",
              ),
              SizedBox(height: 20),
              /// Province or State
              Obx(
                () => DropdownButtonFormField<String>(
                  isExpanded: true,
                  value: controller.selectedProvince.value.isEmpty
                      ? null
                      : controller.selectedProvince.value,
                  hint: const Text('Province/State'),

                  decoration: InputDecoration(
                    labelText: "Province/State",
                    labelStyle: AppTextStyle.textStyle14GreyW500,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: AppColors.primaryColor,
                        width: 1.5,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: AppColors.primaryColor,
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: AppColors.primaryColor,
                        width: 1.5,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: controller.provinces
                      .map(
                        (address) => DropdownMenuItem(
                          value: address,
                          child: Text(address, overflow: TextOverflow.ellipsis),
                        ),
                      )
                      .toList(),
                  onChanged: (val) {
                    if (val != null) controller.selectedProvince.value = val;
                  },
                ),
              ),
              SizedBox(height: 20),
              CustomTextFormField(
                controller: controller.postalCodeController,
                hintText: "Postal Code",
              ),
              SizedBox(height: 20),
              /// Country
              Obx(
                () => DropdownButtonFormField<String>(
                  isExpanded: true,
                  value: controller.selectedCountry.value.isEmpty
                      ? null
                      : controller.selectedCountry.value,
                  hint: const Text('Country'),
                  decoration: InputDecoration(
                    labelText: "Country",
                    labelStyle: AppTextStyle.textStyle14GreyW500,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: AppColors.primaryColor,
                        width: 1.5,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: AppColors.primaryColor,
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: AppColors.primaryColor,
                        width: 1.5,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: controller.country
                      .map(
                        (address) => DropdownMenuItem(
                          value: address,
                          child: Text(address, overflow: TextOverflow.ellipsis),
                        ),
                      )
                      .toList(),
                  onChanged: (val) {
                    if (val != null) controller.selectedCountry.value = val;
                  },
                ),
              ),
              SizedBox(height: 20),
              CustomTextFormField(
                controller: controller.phoneController,
                hintText: "Phone Number",
              ),
              SizedBox(height: 20),
              CustomTextFormField(
                controller: controller.otherController,
                hintText: "Other Notes",
              ),
              SizedBox(height: 20),
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: controller.paymentOptions.map((option) {
                    bool isSelected =
                        controller.selectedPaymentOption.value == option["id"];
                    return GestureDetector(
                      onTap: () => controller.selectedPaymentOption(
                        option["id"] as String,
                      ),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        padding: EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 16,
                        ),
                        width: 150,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.blue.shade50
                              : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected
                                ? Colors.blue
                                : Colors.grey.shade300,
                            width: isSelected ? 2 : 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade200,
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              backgroundColor: option["color"] as Color,
                              radius: 25,
                              child: FaIcon(
                                option["icon"] as IconData,
                                size: 28,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 12),
                            Text(
                              option["title"] as String,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Radio<String>(
                              value: option["id"] as String,
                              groupValue:
                                  controller.selectedPaymentOption.value,
                              onChanged: (value) {
                                if (value != null) {
                                  controller.selectedPaymentOption(value);
                                }
                              },
                              activeColor: Colors.blue,
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 20),
              PrimaryButton(title: "Order Now", onTap: () {
                Get.to(() => MonerisWebView());
              }),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
// 🚚 Delivery options
