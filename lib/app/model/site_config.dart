class SiteConfig {
  final String siteTitle;
  final String description;
  final String siteLogo;
  final String siteIdenty;
  final String currency;
  final String payEmail;
  final PayCard? payCard;

  SiteConfig({
    required this.siteTitle,
    required this.description,
    required this.siteLogo,
    required this.siteIdenty,
    required this.currency,
    required this.payEmail,
    this.payCard,
  });

  factory SiteConfig.fromJson(Map<String, dynamic> json) {
    return SiteConfig(
      siteTitle: json["SiteTitle"] ?? "",
      description: json["Description "] ?? json["Description"] ?? "",
      siteLogo: json["SiteLogo"] ?? "",
      siteIdenty: json["SiteIdenty"] ?? "",
      currency: json["Currency"] ?? "",
      payEmail: json["PayEmail"] ?? "",
      payCard: json["PayCard"] != null ? PayCard.fromJson(json["PayCard"]) : null,
    );
  }
}

class PayCard {
  final String lebel;
  final String storeId;
  final String apiToken;
  final String checkoutId;
  final String paymentMode;
  final String environmentUrl;

  PayCard({
    required this.lebel,
    required this.storeId,
    required this.apiToken,
    required this.checkoutId,
    required this.paymentMode,
    required this.environmentUrl,
  });

  factory PayCard.fromJson(Map<String, dynamic> json) {
    return PayCard(
      lebel: json["Lebel"] ?? "",
      storeId: json["StoreId"] ?? "",
      apiToken: json["ApiToken"] ?? "",
      checkoutId: json["CheckoutID"] ?? "",
      paymentMode: json["PaymentMode"] ?? "",
      environmentUrl: json["EnvironmentURL"] ?? "",
    );
  }
}
