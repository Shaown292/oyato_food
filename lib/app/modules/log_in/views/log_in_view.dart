import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:oyato_food/app/data/app_colors.dart';
import 'package:oyato_food/app/data/app_text_style.dart';
import 'package:oyato_food/app/modules/log_in/controllers/log_in_controller.dart';
import 'package:oyato_food/app/routes/app_pages.dart';
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
               Text(
                "Login Account",
                style: AppTextStyle.textStyle26BlackBold,
              ),
              const SizedBox(height: 6),
              Text(
                "Please log in with your account",
                style: AppTextStyle.textStyle14GreyW500,
              ),
              const SizedBox(height: 30),


              // Email Field
               Text(
                "Email",
                 style: AppTextStyle.textStyle14BlackBold,
              ),
              const SizedBox(height: 8),
             CustomTextFormField(
               prefixIcon: Icon(Icons.mail_outline, color: AppColors.primaryColor,),
               hintText: "Enter your mail",
               controller: controller.emailController,
             ),
              const SizedBox(height: 20),

              // Password Field
               Text(
                "Password",
                style: AppTextStyle.textStyle14BlackBold,
              ),
              const SizedBox(height: 8),
              CustomTextFormField(
                prefixIcon: Icon(Icons.lock, color: AppColors.primaryColor,),
                hintText: "Enter your password",
                controller: controller.passwordController,
                obsCureText: true,
              ),
              SizedBox(height: 10,),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  "Forget Password?",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              Obx(
                    () => controller.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    :   PrimaryButton(
                  title: "Log in",
                  onTap: () {

                    if(controller.emailController.text.isEmpty || controller.passwordController.text.isEmpty ){
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
                      return controller.login(
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
                    "Sign In with Google",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  onPressed: () {
                    controller.signInWithGoogle();
                  },
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
                    "Sign In with Facebook",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  onPressed: () {},
                ),
              ),
              SizedBox(height: 40,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      "Don't have an account?",
                      style: AppTextStyle.textStyle14GreyW500
                  ),
                  SizedBox(width: 5,),
                  InkWell(
                    onTap: ()=> Get.toNamed(Routes.CREATE_ACCOUNT),
                    child: Text(
                        "Create Account",
                        style: AppTextStyle.textStyle16GreenW500
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
