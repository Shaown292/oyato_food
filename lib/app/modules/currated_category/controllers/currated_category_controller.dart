import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../api_service/api_provider.dart';
import '../../../model/currated_category_model.dart';
import '../../../model/currated_product_model.dart';

class CurratedCategoryController extends GetxController {

  RxList<CurratedCategoryModel> categories = <CurratedCategoryModel>[].obs;
  RxList<CurratedProductModel> selectedProducts = <CurratedProductModel>[].obs;
  // Use Rx<String?> for better null safety when no category is selected
  Rx<String?> selectedCategoryId = Rx<String?>(null);
  final ApiProvider _apiProvider = ApiProvider();
  RxBool isSelected = false.obs;


  Future<void> fetchCurratedCategories() async {
    try {
      final response = await _apiProvider.post("api/inventory.php", {
        "inventory": "CurratedProducts",
        "Cetagorylimit": "6",
        "Productlimit": "12",
        "gettoken": "0123456789"});
      if (response["status"] == "success") {
        final List data = response["data"];

        final List<CurratedCategoryModel> fetchedCategories =
        data.map((e) => CurratedCategoryModel.fromJson(e)).toList();

        categories.value = fetchedCategories;

        if (fetchedCategories.isNotEmpty) {
          // Use the selectCategory method for initial selection for consistency
          selectCategory(fetchedCategories.first);
        } else {
          // Explicitly clear selection if no data
          selectedCategoryId.value = null;
          selectedProducts.value = [];
        }
      }
    } catch (e) {
      print('API Error: $e');
    }
  }

  void selectCategory(CurratedCategoryModel category) {
    // category.id should be String? and matches Rx<String?>
    selectedCategoryId.value = category.id;
    selectedProducts.value = category.products;
    print("C ID: ${selectedCategoryId.value}");
  }

  @override
  void onInit() {
    fetchCurratedCategories();
    super.onInit();
  }
}