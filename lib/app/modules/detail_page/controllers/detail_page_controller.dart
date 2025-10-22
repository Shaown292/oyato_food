import 'dart:convert';

import 'package:get/get.dart';
import 'package:oyato_food/app/modules/dashboard/controllers/dashboard_controller.dart';
import '../../../api_service/api_repository.dart';
import '../../../model/related_product.dart';
import '../../../model/single_product_model.dart';
import '../../cart/controllers/cart_controller.dart';

class DetailPageController extends GetxController {
  final ApiRepository _repository = ApiRepository();
  RxString productId = "".obs;
  RxInt quantity = 1.obs;
  RxDouble price = 1.0.obs;
  RxDouble total = 0.0.obs;
  RxBool isLoading = false.obs;
  RxList<Product> products = <Product>[].obs;
  RxList<RelatedProduct> relatedProducts = <RelatedProduct>[].obs;
  RxString errorMessage = "".obs;
  RxBool isSelected = false.obs;
  // final cartController = Get.put(CartController());
  // final DashboardController dashboardController = Get.find(DashboardController());


  void fetchProducts() async {
    try {
      isLoading(true);
      errorMessage("");
      final data = await _repository.fetchProducts(productId: productId.value);
      // final related = await _repository.fetchRelatedProducts();
      products.assignAll(data);
      price.value = double.parse(products[0].regularPrice);
      // relatedProducts.assignAll(related);
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }
  void fetchRelatedProducts() async {
    try {
      isLoading(true);
      errorMessage("");
      final data = await _repository.fetchRelatedProducts(productId: productId.value);
      relatedProducts.assignAll(data);
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }
  void addToCart() async {
    try {
      print("working 1");
      isLoading(true);
      errorMessage("");
      await _repository.addToCart(productId: productId.value);
      // relatedProducts.assignAll(data);
    } catch (e) {
      // print("working 2");
      errorMessage(e.toString());
    } finally {
      // print("working 3");
      isLoading(false);
    }
  }
  void addToWishlist() async {
    try {

      isLoading(true);
      errorMessage("");
      await _repository.addToWishlist(productId: productId.value);
      // relatedProducts.assignAll(data);
    } catch (e) {
      // print("working 2");
      errorMessage(e.toString());
    } finally {
      // print("working 3");
      isLoading(false);
    }
  }
  void deleteFromWishlist() async {
    try {

      isLoading(true);
      errorMessage("");
      await _repository.deleteFromWishlist(productId: productId.value);
      // relatedProducts.assignAll(data);
    } catch (e) {
      // print("working 2");
      errorMessage(e.toString());
    } finally {
      // print("working 3");
      isLoading(false);
    }
  }


  @override
  void onInit() {
    // grab the argument when the page loads
    productId.value = Get.arguments ?? '';
    print("entered $productId");
    fetchProducts();
    fetchRelatedProducts();
    // loadCart();
    // TODO: implement onInit
    super.onInit();
  }
}
