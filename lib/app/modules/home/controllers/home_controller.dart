import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:oyato_food/app/api_service/api_provider.dart';
import 'package:oyato_food/app/model/category_model.dart';

import '../../../api_service/api_repository.dart';
import '../../../model/all_product_model.dart';
import '../../../model/banner_model.dart';

class HomeController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  final ApiRepository _repository = ApiRepository();
  final ApiProvider _apiProvider = ApiProvider();

  final List<String> imageUrls = [
    "https://picsum.photos/id/237/800/400",  // Random dog
    "https://picsum.photos/id/1015/800/400", // Mountain landscape
    "https://picsum.photos/id/1025/800/400", // Puppy
    "https://picsum.photos/id/1003/800/400", // River
    "https://picsum.photos/id/1018/800/400", // Forest road
  ];
  // Sample category data
  var errorMessage = "".obs;
  RxBool isLoading = false.obs;


  final RxList<AllProductData> allProductData = <AllProductData>[].obs;
  Rx<AllProductModel> productResponse = AllProductModel().obs;
  RxList<BannerModel> banners = <BannerModel>[].obs;
  RxList<CategoryData> categories = <CategoryData>[].obs;
  Future<void> allProduct() async {
    final String apiUrl = "${_apiProvider.baseUrl}/api/product.php"; // replace with your endpoint

    try {
      isLoading(true);

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
        },
        body: jsonEncode(
            {
              "get-product": "all",
              "limit":"20",
              "page":"1",
              "gettoken": "0123456789"
            }
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        productResponse.value = AllProductModel.fromJson(data);

        if(productResponse.value.data != null){
          allProductData.assignAll(productResponse.value.data!);
          print(allProductData);
        }
        else{
          allProductData.clear();
        }
      } else {
        Get.snackbar("Error", "Failed: ${response.body}");
      }
    } catch (e) {
      Get.snackbar("Exception", e.toString());
    } finally {
      isLoading(false);
    }
  }

  void fetchBanners() async {
    try {
      isLoading(true);
      final data = await _repository.fetchBanners();
      banners.value = data;


    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }
  void fetchCategories() async {
    try {
      isLoading(true);
      final data = await _repository.fetchAllCategory();
      categories.value = data;
      debugPrint("Category Data ${categories[0].categoryName}");
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    allProduct();
    fetchBanners();
    fetchCategories();
  }

}
