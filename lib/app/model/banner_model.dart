class BannerModel {
  final int id;
  final String title;
  final String buttonText;
  final String buttonURL;
  final String sideImage;
  final String colorPicker;

  BannerModel({
    required this.id,
    required this.title,
    required this.buttonText,
    required this.buttonURL,
    required this.sideImage,
    required this.colorPicker,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'],
      title: json['Title'] ?? "",
      buttonText: json['ButtonText'] ?? "",
      buttonURL: json['ButtonURL'] ?? "",
      sideImage: json['SideImage'] ?? "",
      colorPicker: json['colorPicker'] ?? "#FFFFFF",
    );
  }
}
