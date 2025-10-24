import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:oyato_food/app/api_service/api_repository.dart';
import 'package:oyato_food/app/data/app_colors.dart';
import 'package:oyato_food/app/model/shop_location.dart';
import 'package:oyato_food/app/modules/cart/controllers/cart_controller.dart';

class CheckoutController extends GetxController {
  CartController cartController = Get.put(CartController());
  final ApiRepository _repository = ApiRepository();


  var selectedDeliveryOption = "".obs;
  var selectedPaymentOption = "".obs;
  RxInt quantity = 1.obs;
  RxString deliveryOption = 'Home Delivery'.obs;
  RxString selectedAddress = ''.obs;
  RxString latitude = ''.obs;
  RxString longitude = ''.obs;
  RxString location = ''.obs;
  RxString selectedProvince= ''.obs;
  RxString selectedCountry= ''.obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = "".obs;
  RxList<ShopLocation>  shopDetails = <ShopLocation>[].obs;
  RxList<String>  shopLocation = <String>[].obs;
  RxList<String> provinces = <String>[].obs;


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

  void fetchShopLocation() async {
    try {
      isLoading(true);
      final data = await _repository.fetchShopLocation();
      // convert to location names for dropdown
      shopLocation.value = data.map((e) => e.location).toList();
      shopDetails.value = data;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchProvinces() async {
    try {
      isLoading(true);
      errorMessage('');
      final result = await _repository.fetchProvince();
      provinces.value = result; // must return List<String>
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
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
    fetchShopLocation();
    fetchProvinces();
    super.onInit();
    // selectedAddress.value = addressList.first;
    // selectedProvince.value = province.first;
    // selectedCountry.value = country.first;
  }


}
