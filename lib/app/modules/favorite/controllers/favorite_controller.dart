import 'package:get/get.dart';
import 'package:oyato_food/app/model/wishlist_item.dart';

import '../../../api_service/api_repository.dart';

class FavoriteController extends GetxController {
  RxBool isLoading = false.obs;
  RxString errorMessage = "".obs;
  final ApiRepository _repository = ApiRepository();
  RxList<WishlistItem> wishList = <WishlistItem>[].obs;


  void fetchWishlistItems() async {
    try {
      isLoading(true);
      errorMessage("");
      final data = await _repository.fetchWishlistItem();

      wishList.assignAll(data);

    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoading(false);
    }
  }

  void deleteFromWishlist({required String productId}) async {
    try {

      isLoading(true);
      errorMessage("");
      await _repository.deleteFromWishlist(productId: productId);
      // 🪄 Remove the item locally
      wishList.removeWhere((item) => item.id == productId);

      // ✅ This will automatically rebuild the UI wherever Obx is used.
      // Get.snackbar("Success", "Item removed from favorites");
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
    fetchWishlistItems();
    // TODO: implement onInit
    super.onInit();
  }
}
