import 'package:get/get.dart';
import '../../../api_service/api_repository.dart';
import '../../../model/single_product_model.dart';

class ProductSearchController extends GetxController {

  RxString errorMessage = "".obs;
  RxBool isLoading = false.obs;
  final ApiRepository _repository = ApiRepository();
  RxList<Product> products = <Product>[].obs;
  RxString categoryId = "".obs;

  Future<void> fetchSearchProducts() async {
    try {
      isLoading(true);
      errorMessage('');
      final data = await _repository.searchProducts(
        keyword: "",
        categoryId: categoryId.value,
        brand: "",
      );
      products.value = data;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    categoryId.value = Get.arguments ?? "";
    print(categoryId.value);
    fetchSearchProducts();
    // TODO: implement onInit
    super.onInit();
  }
}
