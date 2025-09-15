import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:oyato_food/app/routes/app_pages.dart';

import '../../../data/app_colors.dart';
import '../../../data/app_text_style.dart';
import '../../../widgets/custom_text_field.dart';
import '../../../widgets/primary_button.dart';
import '../controllers/create_account_controller.dart';

class CreateAccountView extends GetView<CreateAccountController> {
  const CreateAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text("Create Account", style: AppTextStyle.textStyle26BlackBold),
              const SizedBox(height: 6),
              Text(
                "Let's create yxsour account",
                style: AppTextStyle.textStyle14GreyW500,
              ),
              const SizedBox(height: 20),

              // Username Field
              Text("Username", style: AppTextStyle.textStyle14BlackBold),
              const SizedBox(height: 8),
              CustomTextFormField(
                prefixIcon: Icon(Icons.person, color: AppColors.primaryColor),
                hintText: "Enter your user name",
                controller: controller.fullNameController,
              ),
              const SizedBox(height: 20),

              // Email Field
              Text("Email", style: AppTextStyle.textStyle14BlackBold),
              const SizedBox(height: 8),
              CustomTextFormField(
                prefixIcon: Icon(
                  Icons.mail_outline,
                  color: AppColors.primaryColor,
                ),
                hintText: "Enter your mail",
                controller: controller.emailController,
              ),
              const SizedBox(height: 20),

              // Password Field
              Text("Password", style: AppTextStyle.textStyle14BlackBold),
              const SizedBox(height: 8),
              CustomTextFormField(
                prefixIcon: Icon(Icons.lock, color: AppColors.primaryColor),
                hintText: "Enter your password",
                controller: controller.passwordController,
                obsCureText: true,
              ),
              const SizedBox(height: 30),

              // Create Account Button
              Obx(
                () => controller.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    :   PrimaryButton(
                  title: "Create Account",
                  onTap: () {

                    if(controller.emailController.text.isEmpty || controller.passwordController.text.isEmpty || controller.fullNameController.text.isEmpty ){
                      return Get.dialog(
                        AlertDialog(
                          title: const Text("Error"),
                          content: Text("Empty"),
                          actions: [
                            TextButton(
                              onPressed: () => Get.back(),
                              child: const Text("OK"),
                            ),
                          ],
                        ),
                      );
                    }
                    else {
                      return controller.createAccount(
                      username: controller.fullNameController.text.toString(),
                      password: controller.passwordController.text
                          .toString()
                          .trim(),
                      email: controller.emailController.text
                          .toString()
                          .trim(),
                    );
                    }
                  },
                ),
              ),

              const SizedBox(height: 25),

              // Divider Text
              Center(
                child: Text(
                  "Or using other method",
                  style: TextStyle(fontSize: 14, color: Colors.grey[500]),
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
                  icon: const FaIcon(
                    FontAwesomeIcons.google,
                    color: Colors.red,
                  ),
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
                  icon: const FaIcon(
                    FontAwesomeIcons.facebook,
                    color: Colors.blue,
                  ),
                  label: const Text(
                    "Sign Up with Facebook",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  onPressed: () {},
                ),
              ),
              SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: AppTextStyle.textStyle14GreyW500,
                  ),
                  SizedBox(width: 5),
                  InkWell(
                    onTap: () => Get.toNamed(Routes.LOG_IN),
                    child: Text(
                      "Log in",
                      style: AppTextStyle.textStyle16GreenW500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
