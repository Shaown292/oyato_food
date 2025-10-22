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

  @override
  void onInit() {
    fetchWishlistItems();
    // TODO: implement onInit
    super.onInit();
  }
}
