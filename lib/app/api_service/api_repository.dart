import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oyato_food/app/model/all_product_model.dart';
import 'package:oyato_food/app/model/best_selling_product.dart';
import 'package:oyato_food/app/model/cart_model.dart';
import 'package:oyato_food/app/model/category_model.dart';
import 'package:oyato_food/app/model/currated_category_model.dart';
import 'package:oyato_food/app/model/shop_location.dart';
import 'package:oyato_food/app/model/single_product_model.dart';
import 'package:oyato_food/app/model/site_config.dart';
import 'package:oyato_food/app/model/wishlist_item.dart';
import '../global_controller/global_controller.dart';
import '../model/banner_model.dart';
import '../model/related_product.dart';
import 'api_provider.dart';

class ApiRepository {
  final ApiProvider _apiProvider = ApiProvider();
  final String token= "0123456789";
  GlobalController globalController = Get.find<GlobalController>();
  Future<List<BannerModel>> fetchBanners() async {
    // If your POST API requires a body, pass it here
    final response = await _apiProvider.post("api/home-slider.php", {
      "home-slider": "get",
      "action": "banner",
      "gettoken": token
    });

    if (response["status"] == "success") {
      final List data = response["response"]["data"];
      return data.map((e) => BannerModel.fromJson(e)).toList();

    } else {
      throw Exception(response["response"]["message"] ?? "Something went wrong");
    }
  }
  Future<List<AllProductData>> fetchAllProduct() async {
    // If your POST API requires a body, pass it here
    final response = await _apiProvider.post("/api/product.php", {
      "get-product": "all",
      "limit":"20",
      "page":"1",
      "gettoken": token
    });

    if (response["status"] == "success") {
      final List data = response["data"];
      return data.map((e) => AllProductData.fromJson(e)).toList();

    } else {
      throw Exception(response["response"]["message"] ?? "Something went wrong");
    }
  }
  Future<List<AllProductData>> fetchDiscountProduct() async {
    final response = await _apiProvider.post("api/product.php", {
      "get-product": "discount",
      "gettoken": token
    });

    if (response["status"] == "success") {
      final List data = response["data"];
      return data.map((e) => AllProductData.fromJson(e)).toList();

    } else {
      throw Exception(response["response"]["message"] ?? "Something went wrong");
    }
  }
  Future<List<Category>> fetchAllCategory() async {
    // If your POST API requires a body, pass it here
    final response = await _apiProvider.post("api/inventory.php", {
      "inventory": "category-all",
      "gettoken": token
    });

    if (response["status"] == "success") {
      final List data = response['response']["data"];
      return data.map((e) => Category.fromJson(e)).toList();

    } else {
      throw Exception(response["response"]["message"] ?? "Something went wrong");
    }
  }
  Future<List<Product>> fetchProducts({required String productId}) async {
    final response = await _apiProvider.post("/api/product.php", {
      "get-product": "single",
      "ProductID": productId,
      "gettoken": token
    });

    if (response["status"] == "success") {
      final List products = response["data"]["ProductInfo"];
      debugPrint("Success Product");
      return products.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception(response["response"]["message"] ?? "Something went wrong");
    }
  }
  Future<List<Product>> searchProducts({required String keyword,required String categoryId, required String brand}) async {
    final response = await _apiProvider.post("/api/product.php", {
      "get-product": "search",
      "searchInput": keyword,
      "searchCategory": categoryId,
      "searchBrand": brand,
      "limit":"20",
      "page":"0",
      "gettoken": token
    });

    if (response["status"] == "success") {
      final List products = response["data"];
      return products.map((e) => Product.fromJson(e)).toList();
    } else {
      throw Exception(response["response"]["message"] ?? "Something went wrong");
    }
  }
  Future<List<RelatedProduct>> fetchRelatedProducts({required String productId}) async {
    final response = await _apiProvider.post("api/product.php", {
      "get-product": "related",
      "ProductID": productId,
      "gettoken": token
    });

    if (response["status"] == "success") {
      final List related = response["data"]["RelatedProduct"];
      return related.map((e) => RelatedProduct.fromJson(e)).toList();
    } else {
      throw Exception(response["response"]["message"] ?? "Something went wrong");
    }
  }
  Future<List<BestSellingProduct>> fetchBestSellingProducts() async {
    final response = await _apiProvider.post("api/product.php", {
      "get-product": "BestSeeling",
      "gettoken": token
    });

    if (response["status"] == "success") {
      final List related = response["data"];
      debugPrint("API CALL OK");
      return related.map((e) => BestSellingProduct.fromJson(e)).toList();
    } else {
      throw Exception(response["response"]["message"] ?? "Something went wrong");
    }
  }
  Future<List<BestSellingProduct>> fetchPopularProducts() async {
    final response = await _apiProvider.post("api/inventory.php", {
      "inventory": "PopularCategories",
      "Cetagorylimit": "8",
      "gettoken": token
    });

    if (response["status"] == "success") {
      final List related = response["data"];
      debugPrint("API CALL OK");
      return related.map((e) => BestSellingProduct.fromJson(e)).toList();
    } else {
      throw Exception(response["response"]["message"] ?? "Something went wrong");
    }
  }
  Future<List<BestSellingProduct>> fetchMustHaveProducts() async {
    final response = await _apiProvider.post("api/product.php", {
      "get-product": "MustHaveProducts",
      "gettoken": token
    });

    if (response["status"] == "success") {
      final List related = response["data"];
      debugPrint("API CALL OK");
      return related.map((e) => BestSellingProduct.fromJson(e)).toList();
    } else {
      throw Exception(response["response"]["message"] ?? "Something went wrong");
    }
  }
  Future<List<CartItem>> fetchCartItems() async {
    final response = await _apiProvider.post("/api/order.php", {
      "order": "get-cart",
      "userid": globalController.userId.value,
      "gettoken": token
    });

    if (response["status"] == "success") {
      final List cart = response["response"]["cart"];
      debugPrint("API CALL OK");

      return cart.map((e) => CartItem.fromJson(e)).toList();
    } else {
      throw Exception(response["response"]["message"] ?? "Something went wrong");
    }
  }
  Future<List<ShopLocation>> fetchShopLocation() async {
    final response = await _apiProvider.post("/api/shop-address.php", {
      "shop-address": "get",
      "gettoken": token
    });

    if (response["status"] == "success") {
      final List cart = response["response"]["data"];
      debugPrint("API CALL OK");

      return cart.map((e) => ShopLocation.fromJson(e)).toList();
    } else {
      throw Exception(response["response"]["message"] ?? "Something went wrong");
    }
  }
  Future<List<String>> fetchProvince() async {
    final response = await _apiProvider.post("api/address.php", {
      "get": "ProvinceState",
      "gettoken": token
    });

      if (response['status'] == 'success') {
        print(response['response']['Data']);
        return List<String>.from(response['response']['Data']);

      } else {
        throw Exception('Failed to load provinces');
      }

  }
  Future<void> addToCart({required String productId}) async {
    print("API 1 ${globalController.userId} ${productId.runtimeType} $token");
    final response = await _apiProvider.post("/api/order.php", {
      "order": "add-cart",
      "userid": globalController.userId.value,
      "ProductID" : productId,
      "gettoken": token
    });
    // print("API Call");
    if (response["status"] == "success") {

      Get.snackbar("Added", response["response"]["message"]);

    } else {
      print("API Call");
      Get.snackbar("Added", response["response"]["message"]);
      throw Exception(response["response"]["message"] ?? "Something went wrong");
    }
  }
  Future<void> updateCart({required String productId, required String id,required int quantity}) async {
    final response = await _apiProvider.post("/api/order.php", {
      "order": "update-cart",
      "userid": globalController.userId.value,
      "ProductID" : productId,
      "id": id,
      "quantity": quantity,
      "gettoken": token
    }

    );
    // print("API Call");
    if (response["status"] == "success") {

      Get.snackbar("Added", response["response"]["message"]);

    } else {
      print("API Call");
      Get.snackbar("Added", response["response"]["message"]);
      throw Exception(response["response"]["message"] ?? "Something went wrong");
    }
  }
  Future<void> removeCart({required String productId, required String id}) async {
    final response = await _apiProvider.post("/api/order.php", {
      "order": "delete-cart",
      "userid": globalController.userId.value,
      "ProductID" : productId,
      "id": id,
      "gettoken": token
    }

    );
    // print("API Call");
    if (response["status"] == "success") {

      // Get.snackbar("Added", response["response"]["message"]);

    } else {
      print("API Call");
      // Get.snackbar("Added", response["response"]["message"]);
      throw Exception(response["response"]["message"] ?? "Something went wrong");
    }
  }
  Future<void> addToWishlist({required String productId}) async {
    final response = await _apiProvider.post("/api/wishlist.php", {
      "wishlist": "add",
      "userid": globalController.userId.value,
      "ProductID" : productId,
      "gettoken": token
    });
    // print("API Call");
    if (response["status"] == "success") {

      Get.snackbar("Bravo", response["response"]["message"]);

    } else {
      print(globalController.userId.value);
      Get.snackbar("Added", response["response"]["message"]);
      throw Exception(response["response"]["message"] ?? "Something went wrong");
    }
  }
  Future<void> deleteFromWishlist({required String productId}) async {
    final response = await _apiProvider.post("/api/wishlist.php", {
      "wishlist": "delete",
      "userid": globalController.userId.value,
      "id" : productId,
      "gettoken": token
    });
    // print("API Call");
    if (response["status"] == "success") {

      Get.snackbar("Sorry", response["response"]["message"]);

    } else {
      print("API Call");
      Get.snackbar("Added", response["response"]["message"]);
      throw Exception(response["response"]["message"] ?? "Something went wrong");
    }
  }
  Future<List<CurratedCategoryModel>> fetchCurratedProduct() async {
    final response = await _apiProvider.post("api/inventory.php", {
      "inventory": "CurratedProducts",
      "Cetagorylimit": "6",
      "Productlimit": "12",
      "gettoken": token
    }

    );
    if (response["status"] == "success") {
      final List related = response["data"];
      debugPrint("API CALL OK");
      return related.map((e) => CurratedCategoryModel.fromJson(e)).toList();
    } else {


      throw Exception(response["response"]["message"] ?? "Something went wrong");
    }
  }
  Future<List<WishlistItem>> fetchWishlistItem() async {
    final response = await _apiProvider.post("/api/wishlist.php", {
      "wishlist": "get",
      "userid": globalController.userId.value,
      "gettoken": token
    }

    );
    if (response["status"] == "success") {
      final List related = response["response"]["data"];
      debugPrint("Wish List API ${globalController.userId.value}");
      return related.map((e) => WishlistItem.fromJson(e)).toList();
    } else {


      throw Exception(response["response"]["message"] ?? "Something went wrong");
    }
  }
  Future<SiteConfig> fetchSiteConfig() async {
    final response = await _apiProvider.post("api/details.php", {
      "get": "site-details",
      "gettoken": token
    }

    );
    if (response["status"] == "success") {
      final  related = response["response"]["Data"];
      return  SiteConfig.fromJson(related);

    } else {


      throw Exception(response["response"]["message"] ?? "Something went wrong");
    }
  }




}
