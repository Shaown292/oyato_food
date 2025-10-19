import 'package:get/get.dart';

import '../controllers/currated_category_controller.dart';

class CurratedCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CurratedCategoryController>(
      () => CurratedCategoryController(),
    );
  }
}
