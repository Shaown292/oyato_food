// controllers/cart_controller.dart
import 'package:get/get.dart';
import 'package:oyato_food/app/model/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../api_service/api_repository.dart';
import '../../../model/single_product_model.dart';

class CartController extends GetxController {
  final ApiRepository _repository = ApiRepository();
  RxBool isLoading = false.obs;
  RxList<CartItem> cartItems = <CartItem>[].obs;
  RxString errorMessage = "".obs;
  RxDouble total = 0.0.obs;
  void fetchCartItems() async {
    try {
      isLoading(true);
      errorMessage("");
      final data = await _repository.fetchCartItems();
      // Total price calculation
      cartItems.assignAll(data);
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }
  void updateItems({required String productId, required String id, required int quantity}) async {
    try {
      isLoading(true);
      errorMessage("");
      await _repository.updateCart(productId: productId, id: id, quantity: quantity);

    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }
  void removeItems({required String productId, required String id, }) async {
    try {
      isLoading(true);
      errorMessage("");
      await _repository.removeCart(productId: productId, id: id);

    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }
  // Calculate total price
  double get totalPrice => cartItems.fold(
      0, (sum, item) => sum + (item.price * item.quantity.toInt()) + item.tax);

  /// ➕ Increment
  void incrementItem(String id) {
    final index = cartItems.indexWhere((item) => item.id == id);
    if (index != -1) {
      final item = cartItems[index];
      item.quantity++;
      cartItems.refresh();
      updateItems(productId: item.productID, id: item.id, quantity: item.quantity);
    }
  }

  /// ➖ Decrement
  void decrementItem(String id) {
    final index = cartItems.indexWhere((item) => item.id == id);
    if (index != -1) {
      final item = cartItems[index];
      if (item.quantity > 1) {
        item.quantity--;
        cartItems.refresh();
        print("update called");
        updateItems(
            productId: item.productID, id: item.id, quantity: item.quantity);
      }

      else {
        final item = cartItems[index];
        cartItems.removeAt(index);
        removeItems(productId: item.productID, id: item.id);
        print("Removed called");
        Get.snackbar(
          'Item Removed',
          '${item.title} has been removed from your cart',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }



  @override
  void onInit() {
    fetchCartItems();
    // TODO: implement onInit
    super.onInit();
  }

}
