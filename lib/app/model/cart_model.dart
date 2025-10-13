class CartItem {
  final String id;
  final String productID;
  final String title;
  final String image;
   int quantity;
  final double price;
  final double tax;
  final String dangerousType;

  CartItem({
    required this.id,
    required this.productID,
    required this.title,
    required this.image,
    required this.quantity,
    required this.price,
    required this.tax,
    required this.dangerousType,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'] ?? '',
      productID: json['productID'] ?? '',
      title: json['Title'] ?? '',
      image: json['ProductImage'] ?? '',
      quantity: int.tryParse(json['Quantity'].toString()) ?? 0,
      price: double.tryParse(json['ProductPrice'].toString()) ?? 0.0,
      tax: double.tryParse(json['Tax'].toString()) ?? 0.0,
      dangerousType: json['DangerousType'] ?? '',
    );
  }
}
