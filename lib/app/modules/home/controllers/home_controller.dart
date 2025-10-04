import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:oyato_food/app/api_service/api_provider.dart';
import 'package:oyato_food/app/model/best_selling_product.dart';
import 'package:oyato_food/app/model/category_model.dart';
import 'package:oyato_food/app/model/single_product_model.dart';

import '../../../api_service/api_repository.dart';
import '../../../model/all_product_model.dart';
import '../../../model/banner_model.dart';

class HomeController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  final ApiRepository _repository = ApiRepository();

  final List<String> imageUrls = [
    "https://picsum.photos/id/237/800/400",  // Random dog
    "https://picsum.photos/id/1015/800/400", // Mountain landscape
    "https://picsum.photos/id/1025/800/400", // Puppy
    "https://picsum.photos/id/1003/800/400", // River
    "https://picsum.photos/id/1018/800/400", // Forest road
  ];
  // Sample category data
  RxString errorMessage = "".obs;
  RxBool isLoading = false.obs;


  RxList<AllProductData> allProductData = <AllProductData>[].obs;
  Rx<AllProductModel> productResponse = AllProductModel().obs;
  RxList<BannerModel> banners = <BannerModel>[].obs;
  RxList<Category> categories = <Category>[].obs;
  RxList<BestSellingProduct> bestSelling = <BestSellingProduct>[].obs;

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
      isLoading.value = true;
      final data = await _repository.fetchAllProduct();
      allProductData.value = data;


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
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }
  void fetchBestSelling() async {
    try {
      isLoading(true);
      final data = await _repository.fetchBestSellingProducts();
      bestSelling.value = data;
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
    fetchBestSelling();
  }

}
