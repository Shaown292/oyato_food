class AllCategory {
  List<CategoryData>? data;

  AllCategory({this.data});

  AllCategory.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <CategoryData>[];
      json['data'].forEach((v) {
        data!.add(CategoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryData {
  String? id;
  String? categoryID;
  String? categoryName;
  String? totalProduct;
  String? categoryImage;

  CategoryData(
      {this.id,
        this.categoryID,
        this.categoryName,
        this.totalProduct,
        this.categoryImage});

  CategoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryID = json['CategoryID'];
    categoryName = json['CategoryName'];
    totalProduct = json['TotalProduct'];
    categoryImage = json['CategoryImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['CategoryID'] = categoryID;
    data['CategoryName'] = categoryName;
    data['TotalProduct'] = totalProduct;
    data['CategoryImage'] = categoryImage;
    return data;
  }
}
