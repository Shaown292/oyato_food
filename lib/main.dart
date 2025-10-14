import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:oyato_food/app/global_controller/global_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/routes/app_pages.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  Get.put(GlobalController(prefs));
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false, // <-- Hide debug banner
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
