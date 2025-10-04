class RelatedProduct {
  final String productID;
  final String title;
  final String image;
  final String regularPrice;
  final String sellsPrice;
  final String stockLimit;
  final String type;

  RelatedProduct({
    required this.productID,
    required this.title,
    required this.image,
    required this.regularPrice,
    required this.sellsPrice,
    required this.stockLimit,
    required this.type,
  });

  factory RelatedProduct.fromJson(Map<String, dynamic> json) {
    return RelatedProduct(
      productID: json['ProductID'] ?? "",
      title: json['Title'] ?? "",
      image: json['Image'] ?? "",
      regularPrice: json['RegularPrice'] ?? "0.00",
      sellsPrice: json['SellsPrice'] ?? "",
      stockLimit: json['StockLimit'] ?? "",
      type: json['type'] ?? "",
    );
  }
}
