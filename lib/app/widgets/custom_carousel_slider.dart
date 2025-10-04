import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:oyato_food/app/model/banner_model.dart';

class CustomCarouselSlider extends StatelessWidget {
  final List<BannerModel> sliderData;
  const CustomCarouselSlider({super.key, required this.sliderData,});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: sliderData.length,
      itemBuilder: (context, index, realIndex) {
        final url = sliderData[index].sideImage;
        return Image.network(
          url,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: 180,
              width: MediaQuery.of(context).size.width * 0.85,
              color: Colors.grey[300],
              child: Icon(Icons.broken_image, color: Colors.grey),
            );
          },
        );

      },
      options: CarouselOptions(
        height: 180,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.85,
      ),
    );
  }
}
