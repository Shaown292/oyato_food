import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:oyato_food/app/data/app_colors.dart';
import 'package:oyato_food/app/widgets/custom_text_field.dart';
import 'package:oyato_food/app/widgets/primary_button.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,

        title: const Text(
          "Edit Profile",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                // Profile Picture
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    "https://via.placeholder.com/150", // replace with actual image
                  ),
                ),
                const SizedBox(height: 30),

                // Username
                CustomTextFormField(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: FaIcon(FontAwesomeIcons.solidUser, color: AppColors.primaryColor,
                    size: 24, ),
                  ),
                  hintText: "Shaown",
                  readOnly: true,
                ),

                const SizedBox(height: 20),

                // Email
                CustomTextFormField(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: FaIcon(FontAwesomeIcons.solidMessage, color: AppColors.primaryColor,),
                  ),
                  hintText: "Kzshaown@gmail.com",
                  readOnly: true,
                ),


                const SizedBox(height: 20),

                // Linked Account
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Account Liked With",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Row(
                    children: const [
                      FaIcon(FontAwesomeIcons.google, size: 24, color: AppColors.primaryColor),
                      SizedBox(width: 10),
                      Text(
                        "Google",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Spacer(),
                      Icon(Icons.link, color: Colors.grey),
                    ],
                  ),
                ),

                const SizedBox(height: 40),

                // Save Button
              ],
            ),
            PrimaryButton(title: "Save Change", onTap: (){})
          ],
        ),
      ),
    );
  }

  Widget buildInputField({
    required String label,
    required IconData icon,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.deepPurple),
              const SizedBox(width: 10),
              Text(value, style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ],
    );
  }
}
