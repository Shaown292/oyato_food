class AllProductModel {
  String? status;
  Response? response;
  List<AllProductData>? data;

  AllProductModel({this.status, this.response, this.data});

  AllProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    response = json['response'] != null
        ? Response.fromJson(json['response'])
        : null;
    if (json['data'] != null) {
      data = <AllProductData>[];
      json['data'].forEach((v) {
        data!.add(AllProductData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (response != null) {
      data['response'] = response!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Response {
  String? message;

  Response({this.message});

  Response.fromJson(Map<String, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    return data;
  }
}

class AllProductData {
  String? productID;
  String? title;
  String? shortDescription;
  String? description;
  String? image;
  List<String>? galleryImg;
  String? regularPrice;
  String? sellsPrice;
  String? sKU;
  String? stockLimit;
  String? size;
  Inventory? inventory;
  String? type;

  AllProductData(
      {this.productID,
        this.title,
        this.shortDescription,
        this.description,
        this.image,
        this.galleryImg,
        this.regularPrice,
        this.sellsPrice,
        this.sKU,
        this.stockLimit,
        this.size,
        this.inventory,
        this.type});

  AllProductData.fromJson(Map<String, dynamic> json) {
    productID = json['ProductID'];
    title = json['Title'];
    shortDescription = json['Short_Description'];
    description = json['Description'];
    image = json['Image'];
    galleryImg = json['Gallery_img'].cast<String>();
    regularPrice = json['RegularPrice'];
    sellsPrice = json['SellsPrice'];
    sKU = json['SKU'];
    stockLimit = json['StockLimit'];
    size = json['Size'];
    inventory = json['Inventory'] != null
        ? Inventory.fromJson(json['Inventory'])
        : null;
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ProductID'] = productID;
    data['Title'] = title;
    data['Short_Description'] = shortDescription;
    data['Description'] = description;
    data['Image'] = image;
    data['Gallery_img'] = galleryImg;
    data['RegularPrice'] = regularPrice;
    data['SellsPrice'] = sellsPrice;
    data['SKU'] = sKU;
    data['StockLimit'] = stockLimit;
    data['Size'] = size;
    if (inventory != null) {
      data['Inventory'] = inventory!.toJson();
    }
    data['type'] = type;
    return data;
  }
}

class Inventory {
  String? manufacturer;
  String? vendor;
  String? category;
  String? tags;

  Inventory({this.manufacturer, this.vendor, this.category, this.tags});

  Inventory.fromJson(Map<String, dynamic> json) {
    manufacturer = json['Manufacturer'];
    vendor = json['Vendor'];
    category = json['Category'];
    tags = json['Tags'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Manufacturer'] = manufacturer;
    data['Vendor'] = vendor;
    data['Category'] = category;
    data['Tags'] = tags;
    return data;
  }
}
