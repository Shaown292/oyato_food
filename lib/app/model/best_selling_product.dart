class BestSellingProduct {
  final String productID;
  final String title;
  final String categoryName;
  final String shortDescription;
  final String description;
  final String image;
  final String productImage;
  final List<String> galleryImages;
  final String regularPrice;
  final String sellsPrice;
  final String sku;
  final String stockLimit;
  final String size;
  final Map<String, dynamic> inventory;
  final String type;

  BestSellingProduct({
    required this.productID,
    required this.title,
    required this.categoryName,
    required this.shortDescription,
    required this.description,
    required this.image,
    required this.productImage,
    required this.galleryImages,
    required this.regularPrice,
    required this.sellsPrice,
    required this.sku,
    required this.stockLimit,
    required this.size,
    required this.inventory,
    required this.type,
  });

  factory BestSellingProduct.fromJson(Map<String, dynamic> json) {
    return BestSellingProduct(
      productID: json['ProductID'] ?? "",
      title: json['Title'] ?? "",
      categoryName: json['CategoryName'] ?? "",
      shortDescription: json['Short_Description'] ?? "",
      description: json['Description'] ?? "",
      image: json['Image'] ?? "",
      productImage: json['CategoryImage'] ?? "",
      galleryImages: (json['Gallery_img'] as List?)?.map((e) => e.toString()).toList() ?? [],
      regularPrice: json['RegularPrice'] ?? "0.00",
      sellsPrice: json['SellsPrice'] ?? "",
      sku: json['SKU'] ?? "",
      stockLimit: json['StockLimit'] ?? "",
      size: json['Size'] ?? "",
      inventory: json['Inventory'] ?? {},
      type: json['type'] ?? "",

    );
  }
}
