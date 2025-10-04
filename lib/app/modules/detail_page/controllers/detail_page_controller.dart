import 'package:get/get.dart';

import '../../../api_service/api_repository.dart';
import '../../../model/related_product.dart';
import '../../../model/single_product_model.dart';

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

  @override
  void onInit() {
    // grab the argument when the page loads
    productId.value = Get.arguments ?? '';
    print("entered $productId");
    fetchProducts();
    fetchRelatedProducts();
    // TODO: implement onInit
    super.onInit();
  }
}
