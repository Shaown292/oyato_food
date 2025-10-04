import 'package:flutter/material.dart';
import 'package:oyato_food/app/model/all_product_model.dart';
import 'package:oyato_food/app/model/best_selling_product.dart';
import 'package:oyato_food/app/model/category_model.dart';
import 'package:oyato_food/app/model/single_product_model.dart';
import '../model/banner_model.dart';
import '../model/related_product.dart';
import 'api_provider.dart';

class ApiRepository {
  final ApiProvider _apiProvider = ApiProvider();
  final String token= "0123456789";

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
      print("Syate ${response["status"]}");
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
}
