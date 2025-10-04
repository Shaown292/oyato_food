class Subcategory {
  final String id;
  final String name;
  final String description;
  final String logo;
  final String totalProduct;
  final String date;

  Subcategory({
    required this.id,
    required this.name,
    required this.description,
    required this.logo,
    required this.totalProduct,
    required this.date,
  });

  factory Subcategory.fromJson(Map<String, dynamic> json) {
    return Subcategory(
      id: json['id'] ?? "",
      name: json['Name'] ?? "",
      description: json['Description'] ?? "",
      logo: json['Logo'] ?? "",
      totalProduct: json['TotalProduct'] ?? "0",
      date: json['date'] ?? "",
    );
  }
}

class Category {
  final String id;
  final String name;
  final String description;
  final String logo;
  final String totalProduct;
  final String date;
  final List<Subcategory> subcategories;

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.logo,
    required this.totalProduct,
    required this.date,
    required this.subcategories,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] ?? "",
      name: json['Name'] ?? "",
      description: json['Description'] ?? "",
      logo: json['Logo'] ?? "",
      totalProduct: json['TotalProduct'] ?? "0",
      date: json['date'] ?? "",
      subcategories: (json['Subcategories'] as List?)
          ?.map((e) => Subcategory.fromJson(e))
          .toList() ??
          [],
    );
  }
}
