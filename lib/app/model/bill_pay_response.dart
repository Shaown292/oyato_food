

class BillPayResponse {
  final PriceDetail priceDetail;
  final ShippingDetail shippingDetail;

  BillPayResponse({required this.priceDetail, required this.shippingDetail});

  factory BillPayResponse.fromJson(Map<String, dynamic> json) {
    return BillPayResponse(
      priceDetail: PriceDetail.fromJson(json['PriceDeatil']),
      shippingDetail: ShippingDetail.fromJson(json['ShippingDetail']),
    );
  }
}

class PriceDetail {
  final double tax;
  final double shippingCost;
  final double couponCommission;
  final double totalAmount;
  final double subTotal;

  PriceDetail({
    required this.tax,
    required this.shippingCost,
    required this.couponCommission,
    required this.totalAmount,
    required this.subTotal,
  });

  factory PriceDetail.fromJson(Map<String, dynamic> json) {
    return PriceDetail(
      tax: (json['Tax'] ?? 0).toDouble(),
      shippingCost: (json['ShippingCost'] ?? 0).toDouble(),
      couponCommission: (json['CouponCommission'] ?? 0).toDouble(),
      totalAmount: (json['TotalAmount'] ?? 0).toDouble(),
      subTotal: (json['SubTotal'] ?? 0).toDouble(),
    );
  }
}

class ShippingDetail {
  final String country;
  final String city;
  final String state;
  final String phone;
  final String orderNotes;
  final BillingAddress billingAddress;

  ShippingDetail({
    required this.country,
    required this.city,
    required this.state,
    required this.phone,
    required this.orderNotes,
    required this.billingAddress,
  });

  factory ShippingDetail.fromJson(Map<String, dynamic> json) {
    return ShippingDetail(
      country: json['Country'] ?? '',
      city: json['City'] ?? '',
      state: json['State'] ?? '',
      phone: json['Phone'] ?? '',
      orderNotes: json['OrderNotes'] ?? '',
      billingAddress: BillingAddress.fromJson(json['BillingAddress']),
    );
  }
}

class BillingAddress {
  final String email;
  final String firstName;
  final String lastName;
  final String street;
  final String city;
  final String state;
  final String zip;
  final String phone;
  final String deliveryOption;

  BillingAddress({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.street,
    required this.city,
    required this.state,
    required this.zip,
    required this.phone,
    required this.deliveryOption,
  });

  factory BillingAddress.fromJson(Map<String, dynamic> json) {
    return BillingAddress(
      email: json['email_b'] ?? '',
      firstName: json['f_name_b'] ?? '',
      lastName: json['l_name_b'] ?? '',
      street: json['street_b'] ?? '',
      city: json['city_b'] ?? '',
      state: json['state_b'] ?? '',
      zip: json['zip_b'] ?? '',
      phone: json['phone_b'] ?? '',
      deliveryOption: json['delevery_option'] ?? '',
    );
  }
}
