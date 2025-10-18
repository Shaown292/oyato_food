import 'package:get/get.dart';

import '../../../api_service/api_repository.dart';
import '../../../model/all_product_model.dart';

class DiscountController extends GetxController {

  RxString errorMessage = "".obs;
  RxBool isLoading = false.obs;
  final ApiRepository _repository = ApiRepository();


  RxList<AllProductData> allProductData = <AllProductData>[].obs;
  void fetchDiscountProduct() async {
    try {
      isLoading(true);
      final data = await _repository.fetchDiscountProduct();
      if (data.isEmpty) {
        allProductData.clear();
      }
      else{
        allProductData.value = data;
      }

    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    fetchDiscountProduct();
    // TODO: implement onInit
    super.onInit();
  }

}
