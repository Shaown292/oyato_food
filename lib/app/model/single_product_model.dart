// models/product.dart
import 'dart:convert';

class Inventory {
  final String manufacturer;
  final String vendor;
  final String category;
  final String tags;

  Inventory({
    required this.manufacturer,
    required this.vendor,
    required this.category,
    required this.tags,
  });

  factory Inventory.fromJson(Map<String, dynamic> json) {
    return Inventory(
      manufacturer: json['Manufacturer'] ?? "",
      vendor: json['Vendor'] ?? "",
      category: json['Category'] ?? "",
      tags: json['Tags'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Manufacturer': manufacturer,
      'Vendor': vendor,
      'Category': category,
      'Tags': tags,
    };
  }
}

class Product {
  final String productID;
  final String id;
  final String title;
  final String shortDescription;
  final String description;
  final String image;
  final List<String> galleryImages;
  final String regularPrice;
  final String sellsPrice;
  final String sku;
  final String stockLimit;
  final String size;
  final Inventory inventory;
  final String type;

  // 🛒 Quantity field for cart management
  int quantity;

  Product({
    required this.productID,
    required this.id,
    required this.title,
    required this.shortDescription,
    required this.description,
    required this.image,
    required this.galleryImages,
    required this.regularPrice,
    required this.sellsPrice,
    required this.sku,
    required this.stockLimit,
    required this.size,
    required this.inventory,
    required this.type,
    this.quantity = 1,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productID: json['ProductID'] ?? "",
      id: json['id'] ?? "",
      title: json['Title'] ?? "",
      shortDescription: json['Short_Description'] ?? "",
      description: json['Description'] ?? "",
      image: json['Image'] ?? "",
      galleryImages: (json['Gallery_img'] as List?)
          ?.map((e) => e.toString())
          .toList() ??
          [],
      regularPrice: json['RegularPrice'] ?? "",
      sellsPrice: json['SellsPrice'] ?? "",
      sku: json['SKU'] ?? "",
      stockLimit: json['StockLimit'] ?? "",
      size: json['Size'] ?? "",
      inventory: Inventory.fromJson(json['Inventory'] ?? {}),
      type: json['type'] ?? "",
      quantity: json['quantity'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ProductID': productID,
      'id': id,
      'Title': title,
      'Short_Description': shortDescription,
      'Description': description,
      'Image': image,
      'Gallery_img': galleryImages,
      'RegularPrice': regularPrice,
      'SellsPrice': sellsPrice,
      'SKU': sku,
      'StockLimit': stockLimit,
      'Size': size,
      'Inventory': inventory.toJson(),
      'type': type,
      'quantity': quantity,
    };
  }

  String encode() => jsonEncode(toJson());
  factory Product.decode(String source) =>
      Product.fromJson(jsonDecode(source));
}
