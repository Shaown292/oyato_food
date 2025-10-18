import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oyato_food/app/model/best_selling_product.dart';
import 'package:oyato_food/app/model/category_model.dart';
import '../../../api_service/api_repository.dart';
import '../../../model/all_product_model.dart';
import '../../../model/banner_model.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  final ApiRepository _repository = ApiRepository();

  final List<String> imageUrls = [
    "https://picsum.photos/id/237/800/400", // Random dog
    "https://picsum.photos/id/1015/800/400", // Mountain landscape
    "https://picsum.photos/id/1025/800/400", // Puppy
    "https://picsum.photos/id/1003/800/400", // River
    "https://picsum.photos/id/1018/800/400", // Forest road
  ];
  // Sample category data
  RxString errorMessage = "".obs;
  RxBool isLoading = false.obs;

  RxList<AllProductData> allProductData = <AllProductData>[].obs;
  // Rx<AllProductModel> productResponse = AllProductModel().obs;
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
  }
}
