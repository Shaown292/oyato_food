class ShopLocation {
  final String id;
  final String storeName;
  final String location;

  ShopLocation({
    required this.id,
    required this.storeName,
    required this.location,
  });

  factory ShopLocation.fromJson(Map<String, dynamic> json) {
    return ShopLocation(
      id: json['id'] ?? '',
      storeName: json['storeName'] ?? '',
      location: json['location'] ?? '',
    );
  }
}
