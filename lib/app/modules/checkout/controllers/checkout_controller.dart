import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:oyato_food/app/data/app_colors.dart';
import 'package:oyato_food/app/modules/cart/controllers/cart_controller.dart';

class CheckoutController extends GetxController {
  CartController cartController = Get.put(CartController());
  var selectedDeliveryOption = "".obs;
  var selectedPaymentOption = "".obs;
  RxInt quantity = 1.obs;
  RxString deliveryOption = 'Home Delivery'.obs;
  RxString selectedAddress = ''.obs;
  RxString selectedProvince= ''.obs;
  RxString selectedCountry= ''.obs;

  final List<String> addressList = [
    '3226 Weston Rd, Toronto, ON M9M 2T7, Canada',
    '15 King St W, Toronto, ON M5H 1A1, Canada',
    '500 Yonge St, Toronto, ON M4Y 1X9, Canada'
  ];
  final List<String> province = [
    'British Columbia',
    'Manitoba',
    'Ontario'
  ];
  final List<String> country = [
    'Canada',
    'USA',
  ];

  final emailController = TextEditingController();
  final postalCodeController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final streetController = TextEditingController();
  final cityController = TextEditingController();
  final phoneController = TextEditingController();
  final otherController = TextEditingController();
  final searchAddressController = TextEditingController();

  double get price => 19.99;
  double get total => price * quantity.value;

  void increment() => quantity.value++;
  void decrement() {
    if (quantity.value > 1) quantity.value--;
  }

  @override
  void onClose() {
    emailController.dispose();
    postalCodeController.dispose();
    otherController.dispose();
    phoneController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    streetController.dispose();
    cityController.dispose();
    searchAddressController.dispose();
    super.onClose();
  }

  final deliveryOptions = [
    {
      "id": "1",
      "title": "Home Delivery",
      "icon": FontAwesomeIcons.truck,
      "color": AppColors.primaryColor
    },
    {
      "id": "2",
      "title": "Pick up",
      "icon": FontAwesomeIcons.house,
      "color": AppColors.primaryColor
    },
  ];
  final paymentOptions = [
    {
      "id": "1",
      "title": "Email Transfer",
      "icon": FontAwesomeIcons.message,
      "color": AppColors.primaryColor
    },
    {
      "id": "2",
      "title": "Debit/Credit Card",
      "icon": FontAwesomeIcons.creditCard,
      "color": AppColors.primaryColor
    },
  ];
  void selectDeliveryOption(String id) {
    selectedDeliveryOption.value = id;
  }
  void selectPaymentOption(String id) {
    selectedPaymentOption.value = id;
  }

  @override
  void onInit() {
    cartController;
    // TODO: implement onInit
    super.onInit();
    selectedAddress.value = addressList.first;
    selectedProvince.value = province.first;
    selectedCountry.value = country.first;
  }


}
