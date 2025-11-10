import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:oyato_food/app/api_service/api_repository.dart';
import 'package:oyato_food/app/data/app_colors.dart';
import 'package:oyato_food/app/model/shop_location.dart';
import 'package:oyato_food/app/model/site_config.dart';
import 'package:oyato_food/app/modules/cart/controllers/cart_controller.dart';
import 'package:oyato_food/app/routes/app_pages.dart';

import '../../../model/bill_pay_response.dart';
import '../../../payment_gateway/moneris_preload.dart';

class CheckoutController extends GetxController {
  CartController cartController = Get.put(CartController());
  final ApiRepository _repository = ApiRepository();

  var selectedDeliveryOption = "".obs;
  RxString deliveryOptionId = "".obs;
  var selectedPaymentOption = "".obs;
  RxInt quantity = 1.obs;
  RxString deliveryOption = 'Home Delivery'.obs;
  RxString selectedAddress = ''.obs;
  RxString latitude = ''.obs;
  RxString longitude = ''.obs;
  RxString location = ''.obs;
  RxString selectedProvince = ''.obs;
  RxString selectedCountry = ''.obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = "".obs;
  RxList<ShopLocation> shopDetails = <ShopLocation>[].obs;
  RxList<String> shopLocation = <String>[].obs;
  RxList<String> provinces = <String>[].obs;
  Rxn<PriceDetail> priceDetail = Rxn<PriceDetail>();
  Rxn<ShippingDetail> shippingDetail = Rxn<ShippingDetail>();
  RxString selectedShopId = ''.obs;
  RxString selectedPaymentMethodId = ''.obs;
  RxString shippingCost = "".obs;
  RxDouble subTotal = 0.0.obs;

  final site = Rxn<SiteConfig>();
  String generateOrderId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  String orderId = "";

  final List<String> country = ['Canada', 'USA'];

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
      print("Location calling ${shopDetails.first.id}");
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }
  void emailPay({required String amount, required String email}) async {
    try {
      isLoading(true);
       await _repository.emailPay(amount: amount, email: email);
      // convert to location names for dropdown

    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }
  void fetchShippingCost({required String addressFrom, required String shopId}) async {
    try {
      print("Shipping called");
      final data = await _repository.addShippingAddress(addressFrom: addressFrom, shopId: shopId);
      // convert to location names for dropdown
      shippingCost.value = data.shippingCost;
      print("Shipping Cost ${shippingCost.value}");
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }

  // Change return type from void to Future<BillPayResponse?>
  Future<bool> fetchBillPay(
      {
    required String shippingCost,
    required String deliveryOption,
    required String emailShipping,
    required String fNameShipping,
    required String lNameShipping,
    required String countryShipping,
    required String streetShipping,
    required String cityShipping,
    required String stateShipping,
    required String zipShipping,
    required String phoneShipping,
    required String emailBilling,
    required String fNameBilling,
    required String lNameBilling,
    required String countryBilling,
    required String streetBilling,
    required String cityBilling,
    required String stateBilling,
    required String zipBilling,
    required String phoneBilling,
    required String paymentMethod,
    required String addressFrom,
    required String dangerType,
  }) async
  {
    try {
      isLoading(true);

      // 🧾 Log all parameters being sent
      debugPrint("🟢 --- Fetch BillPay API Params ---");
      debugPrint("ShippingCost: $shippingCost");
      debugPrint("DeliveryOption: $deliveryOption");
      debugPrint("EmailShipping: $emailShipping");
      debugPrint("NameShipping: $fNameShipping $lNameShipping");
      debugPrint("AddressShipping: $streetShipping, $cityShipping, $stateShipping");
      debugPrint("PhoneShipping: $phoneShipping");
      debugPrint("EmailBilling: $emailBilling");
      debugPrint("PaymentMethod: $paymentMethod");
      debugPrint("AddressFrom: $addressFrom");
      debugPrint("DangerousType: $dangerType");
      debugPrint("----------------------------");

      // 🔥 Call API from repository
      final data = await _repository.fetchBillPay(
        shippingCost: shippingCost,
        deliveryOption: deliveryOption,
        emailShipping: emailShipping,
        fNameShipping: fNameShipping,
        lNameShipping: lNameShipping,
        countryShipping: countryShipping,
        streetShipping: streetShipping,
        cityShipping: cityShipping,
        stateShipping: stateShipping,
        zipShipping: zipShipping,
        phoneShipping: phoneShipping,
        emailBilling: emailBilling,
        fNameBilling: fNameBilling,
        lNameBilling: lNameBilling,
        countryBilling: countryBilling,
        streetBilling: streetBilling,
        cityBilling: cityBilling,
        stateBilling: stateBilling,
        zipBilling: zipBilling,
        phoneBilling: phoneBilling,
        paymentMethod: paymentMethod,
        addressFrom: addressFrom,
        dangerType: dangerType,
      );

      if (data.isNotEmpty) {
        // ✅ Success
        final bill = data.first;
        priceDetail.value = bill.priceDetail;
        shippingDetail.value = bill.shippingDetail;
        subTotal.value = priceDetail.value!.subTotal;
        // 🔹 Handle payment logic
        if (paymentMethod == "1") {
          emailPay(amount: subTotal.value.toString(), email: shippingDetail.value!.billingAddress.email);

        } else if (paymentMethod == "2") {

          Get.to(() => MonerisPreloadPage(), arguments: subTotal.value);
        }

        return true;
      } else {
        Get.snackbar("Error", "No data returned from API");
        return false;
      }
    } catch (e) {
      errorMessage.value = e.toString();
      debugPrint("❌ Error: $e");
      Get.snackbar("Error", e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
      return false;
    } finally {
      isLoading(false);
    }
  }



  void fetchSiteConfig() async {
    try {
      isLoading(true);
      print("Fetching site config...");
      final configData = await _repository.fetchSiteConfig();
      site.value = configData;
      print("Site title: ${site.value?.siteTitle}");
    } catch (e, s) {
      print("❌ Error fetching site config: $e");
      print(s);
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
      print("Province calling");
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
      "color": AppColors.primaryColor,
    },
    {
      "id": "2",
      "title": "Pick up",
      "icon": FontAwesomeIcons.house,
      "color": AppColors.primaryColor,
    },
  ];
  final paymentOptions = [
    {
      "id": "1",
      "title": "Email Transfer",
      "icon": FontAwesomeIcons.message,
      "color": AppColors.primaryColor,
    },
    {
      "id": "2",
      "title": "Debit/Credit Card",
      "icon": FontAwesomeIcons.creditCard,
      "color": AppColors.primaryColor,
    },
  ];
  void selectDeliveryOption(String id) {
    selectedDeliveryOption.value = id;
  }

  void selectPaymentOption(String id) {
    selectedPaymentOption.value = id;
  }
  void clearAllFields() {
    // Clear TextEditingControllers
    emailController.clear();
    firstNameController.clear();
    lastNameController.clear();
    streetController.clear();
    cityController.clear();
    postalCodeController.clear();
    phoneController.clear();

    // Reset Rx values
    selectedPaymentOption.value = '';
    selectedCountry.value = '';
    selectedProvince.value = '';
    shippingCost.value = '';
    deliveryOption.value = '';
    // priceDetail.value = PriceDetail(); // assuming model defaults
    // shippingDetail.value = ShippingDetail();

    debugPrint("🧹 All fields cleared successfully");
  }


  @override
  void onInit() {
    cartController;
    // TODO: implement onInit
    fetchShopLocation();
    fetchProvinces();
    fetchSiteConfig();
    selectedDeliveryOption.value = "";
    print("on init working");
    super.onInit();
  }
}
