import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalController extends GetxController {

  final SharedPreferences prefs;
  GlobalController(this.prefs);

  RxString userId = ''.obs;
  RxString getToken = '0123456789'.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadValue();
  }

  Future<void> setValue(String value) async {
    userId.value = value;
    await prefs.setString('myValue', value);
  }

  void loadValue() {
    userId.value = prefs.getString('myValue') ?? '';
  }
}
