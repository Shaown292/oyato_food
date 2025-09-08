import 'dart:ui';

class CategoryModel {
  final String name;
  final int productCount;
  final String imageUrl;
  final Color color;

  CategoryModel({
    required this.name,
    required this.productCount,
    required this.imageUrl,
    required this.color,
  });
}