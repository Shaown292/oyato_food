import 'package:oyato_food/app/model/all_product_model.dart';
import 'package:oyato_food/app/model/category_model.dart';

import '../model/banner_model.dart';
import 'api_provider.dart';

class ApiRepository {
  final ApiProvider _apiProvider = ApiProvider();

  Future<List<BannerModel>> fetchBanners() async {
    // If your POST API requires a body, pass it here
    final response = await _apiProvider.post("api/home-slider.php", {
      "home-slider": "get",
      "action": "banner",
      "gettoken": "0123456789"
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
      "gettoken": "0123456789"
    });

    if (response["status"] == "success") {
      final List data = response["response"]["data"];
      return data.map((e) => AllProductData.fromJson(e)).toList();

    } else {
      throw Exception(response["response"]["message"] ?? "Something went wrong");
    }
  }
  Future<List<CategoryData>> fetchAllCategory() async {
    // If your POST API requires a body, pass it here
    final response = await _apiProvider.post("api/inventory.php", {
      "inventory": "PopularCategories",
      "Cetagorylimit": "8",
      "gettoken": "0123456789"
    });

    if (response["status"] == "success") {
      final List data = response["data"];
      return data.map((e) => CategoryData.fromJson(e)).toList();

    } else {
      throw Exception(response["response"]["message"] ?? "Something went wrong");
    }
  }
}
