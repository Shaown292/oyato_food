import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:oyato_food/app/data/app_text_style.dart';
import 'package:oyato_food/app/widgets/custom_text_field.dart';

import '../../home/widgets/home_widget.dart';
import '../controllers/favorite_controller.dart';

class FavoriteView extends GetView<FavoriteController> {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> products = [
      {
        "name": "Picsum Photos",
        "url": "https://picsum.photos/v2/list",
        "price": "Free",
        "type": "Placeholder",
        "discount": "N/A",
        "description":
            "Easy to use. Just add /200/300 to the URL for a 200x300 image. No API key needed.",
        "example_url": "https://picsum.photos/200/300?random=1", // ✅ WORKS
      },
      {
        "name": "Lorem Picsum",
        "url": "https://picsum.photos/",
        "price": "Free",
        "type": "Placeholder",
        "discount": "N/A",
        "description":
            "A fancy wrapper around Picsum. Offers grayscale, blur, and specific image by ID.",
        "example_url": "https://picsum.photos/seed/picsum/200/300", // ✅ WORKS
      },
      {
        "name": "Dog API",
        "url": "https://dog.ceo/api/breeds/image/random",
        "price": "Free",
        "type": "Animal (Dogs)",
        "discount": "N/A",
        "description":
            "An API for random dog images. Perfect if your app has a single-theme.",
        // Let's use a known, good dog picture URL from their repository
        "example_url":
            "https://images.dog.ceo/breeds/labrador/n02099712_6901.jpg",
        // ✅ WORKS
      },
      {
        "name": "The Cat API",
        "url": "https://api.thecatapi.com/v1/images/search",
        "price": "Free",
        "type": "Animal (Cats)",
        "discount": "N/A",
        "description":
            "An API for random cat images. Requires an API key for high rates.",
        // Let's use a known, good cat picture URL
        "example_url": "https://cdn2.thecatapi.com/images/2k7.jpg", // ✅ WORKS
      },
      {
        "name": "PokéAPI",
        "url": "https://pokeapi.co/api/v2/pokemon/",
        "price": "Free",
        "type": "Game Assets",
        "discount": "N/A",
        "description":
            "API for Pokémon data. Images are stored on a separate CDN.",
        // Let's use the image for the first Pokémon, Bulbasaur
        "example_url":
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/1.png",
        // ✅ WORKS
      },
      {
        "name": "PlaceBear",
        "url": "N/A",
        "price": "Free",
        "type": "Placeholder",
        "discount": "N/A",
        "description":
            "Placeholder service for pictures of bears. Simple and direct.",
        "example_url": "https://placebear.com/200/300", // ✅ WORKS
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('My Favorite', style: AppTextStyle.textStyle18BlackBold),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: FaIcon(FontAwesomeIcons.bell, color: Colors.black87),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: CustomTextFormField(
              prefixIcon: Padding(
                padding: const EdgeInsets.all(10.0),
                child: FaIcon(
                  FontAwesomeIcons.search,
                  size: 25,
                  color: Colors.black54,
                ),
              ),
              hintText: "Search Something...",
              hintTextStyle: AppTextStyle.textStyle14GreyW500,
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
              shrinkWrap: true,
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                final product = products[index];
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.grey.shade100,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                            child: Image.network(
                              product["example_url"]!,
                              height: 150,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: FaIcon(
                                FontAwesomeIcons.solidHeart,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product["name"]!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              product["type"]!,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              product["price"].toString(),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
