import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oyato_food/app/model/category_model.dart';

class HomeController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  final List<String> imageUrls = [
    "https://picsum.photos/id/237/800/400",  // Random dog
    "https://picsum.photos/id/1015/800/400", // Mountain landscape
    "https://picsum.photos/id/1025/800/400", // Puppy
    "https://picsum.photos/id/1003/800/400", // River
    "https://picsum.photos/id/1018/800/400", // Forest road
  ];
  // Sample category data
  List<CategoryModel> categories = [
    CategoryModel(
      name: 'New Arrivals',
      productCount: 208,
      imageUrl: 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=600&q=80',
      color: const Color(0xFFE3F2FD),
    ),
    CategoryModel(
      name: 'Clothes',
      productCount: 358,
      imageUrl: 'https://images.unsplash.com/photo-1552374196-c4e7ffc6e126?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=600&q=80',
      color: const Color(0xFFF3E5F5),
    ),
    CategoryModel(
      name: 'Bags',
      productCount: 160,
      imageUrl: 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=600&q=80',
      color: const Color(0xFFFFF8E1),
    ),
    CategoryModel(
      name: 'Shoes',
      productCount: 230,
      imageUrl: 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=600&q=80',
      color: const Color(0xFFE8F5E9),
    ),
    CategoryModel(
      name: 'Electronics',
      productCount: 189,
      imageUrl: 'https://images.unsplash.com/photo-1468495244123-6c6c332eeece?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=600&q=80',
      color: const Color(0xFFE0F7FA),
    ),
    CategoryModel(
      name: 'Accessories',
      productCount: 142,
      imageUrl: 'https://images.unsplash.com/photo-1590649880760-2d4b0f523de7?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=600&q=80',
      color: const Color(0xFFFBE9E7),
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
  }
  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
