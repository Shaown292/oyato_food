import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:oyato_food/app/data/app_colors.dart';
import 'package:oyato_food/app/modules/log_in/controllers/log_in_controller.dart';
import 'package:oyato_food/app/widgets/custom_text_field.dart';
import 'package:oyato_food/app/widgets/primary_button.dart';

class LogInView extends GetView<LogInController> {
  const LogInView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // Title
              const Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "Start learning with create your account",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[500],
                ),
              ),
              const SizedBox(height: 30),

              // Username Field
              const Text(
                "Username",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              const SizedBox(height: 8),
            CustomTextFormField(
              prefixIcon: Icon(Icons.person, color: AppColors.primaryColor,),
              hintText: "Enter your user name",
            ),
              const SizedBox(height: 20),

              // Email Field
              const Text(
                "Email",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              const SizedBox(height: 8),
             CustomTextFormField(
               prefixIcon: Icon(Icons.mail_outline, color: AppColors.primaryColor,),
               hintText: "Enter your mail",
             ),
              const SizedBox(height: 20),

              // Password Field
              const Text(
                "Password",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
              const SizedBox(height: 8),
              CustomTextFormField(
                prefixIcon: Icon(Icons.lock, color: AppColors.primaryColor,),
                hintText: "Enter your password",
              ),
              const SizedBox(height: 30),

              // Create Account Button
           PrimaryButton(title: "Create Account", onTap: () {}),

              const SizedBox(height: 25),

              // Divider Text
              Center(
                child: Text(
                  "Or using other method",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Google Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    side: BorderSide(color: Colors.grey.shade300),
                  ),
                  icon: const FaIcon(FontAwesomeIcons.google, color: Colors.red),
                  label: const Text(
                    "Sign Up with Google",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  onPressed: () {},
                ),
              ),
              const SizedBox(height: 15),

              // Facebook Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    side: BorderSide(color: Colors.grey.shade300),
                  ),
                  icon: const FaIcon(FontAwesomeIcons.facebook, color: Colors.blue),
                  label: const Text(
                    "Sign Up with Facebook",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
