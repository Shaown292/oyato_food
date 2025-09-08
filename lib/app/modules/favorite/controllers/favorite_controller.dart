import 'package:get/get.dart';

class FavoriteController extends GetxController {

  final List<String> imageUrls = [
    "https://picsum.photos/id/237/800/400",  // Random dog
    "https://picsum.photos/id/1015/800/400", // Mountain landscape
    "https://picsum.photos/id/1025/800/400", // Puppy
    "https://picsum.photos/id/1003/800/400", // River
    "https://picsum.photos/id/1018/800/400", // Forest road
  ];

  //TODO: Implement FavoriteController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
