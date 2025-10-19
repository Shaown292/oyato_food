class CurratedProductModel {
  final String title;
  final String image;
  final String regularPrice;
  final String sellsPrice;
  final String productId;

  CurratedProductModel({
    required this.title,
    required this.image,
    required this.regularPrice,
    required this.sellsPrice,
    required this.productId,
  });

  factory CurratedProductModel.fromJson(Map<String, dynamic> json) {
    return CurratedProductModel(
      title: json['title'] ?? '',
      image: json['ProductImage'] ?? '',
      regularPrice: json['RegularPrice'] ?? '',
      sellsPrice: json['SellsPrice'] ?? '',
      productId: json['productID'] ?? '',
    );
  }
}
