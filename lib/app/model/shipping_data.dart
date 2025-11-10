class ShippingData {
  final String shippingCost;
  final String addressFrom;

  ShippingData({
    required this.shippingCost,
    required this.addressFrom,
  });

  factory ShippingData.fromJson(Map<String, dynamic> json) {
    return ShippingData(
      shippingCost: json['ShippingCost'] ?? '0',
      addressFrom: json['addressFrom'] ?? '',
    );
  }
}