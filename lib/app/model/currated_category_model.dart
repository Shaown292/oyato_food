
import 'package:oyato_food/app/model/currated_product_model.dart';

class CurratedCategoryModel {
  final String id;
  final String name;
  final String image;
  final List<CurratedProductModel> products;

  CurratedCategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.products,
  });

  factory CurratedCategoryModel.fromJson(Map<String, dynamic> json) {
    return CurratedCategoryModel(
      id: json['categoryID'] ?? '',
      name: json['categoryName'] ?? '',
      image: json['CategoryImage'] ?? '',
      products: (json['products'] as List<dynamic>)
          .map((p) => CurratedProductModel.fromJson(p))
          .toList(),
    );
  }
}
