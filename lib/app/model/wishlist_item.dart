class WishlistItem {
  final String id;
  final String productId;
  final String title;
  final String image;
  final String regularPrice;
  final String sellsPrice;

  WishlistItem({
    required this.id,
    required this.productId,
    required this.title,
    required this.image,
    required this.regularPrice,
    required this.sellsPrice,
  });

  factory WishlistItem.fromJson(Map<String, dynamic> json) {
    final product = json['ProductDetail'][0]; // since only 1 item inside
    return WishlistItem(
      id: json['id'] ?? '',
      productId: product['ProductID'] ?? '',
      title: product['Title'] ?? '',
      image: product['Image'] ?? '',
      regularPrice: product['RegularPrice'] ?? '',
      sellsPrice: product['SellsPrice'] ?? '',
    );
  }
}
