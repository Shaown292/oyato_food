import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:oyato_food/app/model/best_selling_product.dart';
import 'package:oyato_food/app/model/category_model.dart';
import 'package:oyato_food/app/model/currated_category_model.dart';
import 'package:oyato_food/app/model/currated_product_model.dart';
import '../../../api_service/api_repository.dart';
import '../../../model/all_product_model.dart';
import '../../../model/banner_model.dart';
import '../../../model/single_product_model.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  final ApiRepository _repository = ApiRepository();


  // Sample category data
  RxString errorMessage = "".obs;
  RxBool isLoading = false.obs;

  RxList<AllProductData> allProductData = <AllProductData>[].obs;
  RxList<CurratedCategoryModel> curratedCategories = <CurratedCategoryModel>[].obs;
  RxList<CurratedProductModel> selectedProducts = <CurratedProductModel>[].obs;
  RxString selectedCategoryId = ''.obs;
  RxList<BannerModel> banners = <BannerModel>[].obs;
  RxList<Category> categories = <Category>[].obs;
  RxList<BestSellingProduct> bestSelling = <BestSellingProduct>[].obs;
  RxList<BestSellingProduct> mustHave = <BestSellingProduct>[].obs;
  RxList<BestSellingProduct> popularProduct = <BestSellingProduct>[].obs;

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

  void fetchAllProduct() async {
    try {
      isLoading(true);
      print("Hi ${isLoading.value}");
      final data = await _repository.fetchAllProduct();
      print(isLoading.value);
      if (data.isEmpty) {
        allProductData.clear();
      }
      else{
        print(isLoading.value);
        allProductData.value = data;
      }

    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void fetchCategories() async {
    try {
      isLoading(true);
      final data = await _repository.fetchAllCategory();
      categories.value = data;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }

  void fetchBestSellingMustHavePopular() async {
    try {
      isLoading(true);
      final bestSellingData = await _repository.fetchBestSellingProducts();
      final mustHaveData = await _repository.fetchMustHaveProducts();
      final popularProductData = await _repository.fetchPopularProducts();
      bestSelling.value = bestSellingData;
      mustHave.value = mustHaveData;
      popularProduct.value = popularProductData;
      debugPrint("Data ${bestSelling[0].productID}");
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
    fetchAllProduct();
    fetchBanners();
    fetchCategories();
    fetchBestSellingMustHavePopular();
    // fetchCurratedCategories();
  }
}
