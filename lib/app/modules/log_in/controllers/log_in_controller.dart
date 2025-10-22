// import 'dart:convert';
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:http/http.dart' as http;
// import 'package:oyato_food/app/api_service/api_provider.dart';
// import 'package:oyato_food/app/global_controller/global_controller.dart';
// import 'package:oyato_food/app/routes/app_pages.dart';
//
// class LogInController extends GetxController {
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   final ApiProvider _apiProvider = ApiProvider();
//   GlobalController globalController = Get.find<GlobalController>();
//
//   RxBool isLoading = false.obs;
//   // responseData and errorMessage are kept for future use if needed, but not used in the existing logic.
//   RxString responseData = "".obs;
//   RxString errorMessage = "".obs;
//
//   RxString status = ''.obs;
//
//
//   // FIX: Initialize GoogleSignIn within the GetX lifecycle to ensure it's done at the correct time.
//   // ===================================
//   // SignInWithGoogle Service
//   // ===================================
//
//   // Service For GoogleSignIn
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   // Initialize GoogleSignIn properly
//   final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
//
//   static bool isInitialize = false;
//
//   Future<void> initSignIn() async {
//     if (!isInitialize) {
//       await _googleSignIn.initialize(
//         serverClientId:
//         'YourServerClientID',
//       );
//       isInitialize = true;
//     }
//   }
//
//   Future<UserCredential?> signInWithGoogle() async {
//     try {
//       await initSignIn();
//
//       // Authenticate with the new API
//       final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();
//
//       // final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//       final GoogleSignInAuthentication googleAuth = googleUser.authentication;
//       final String? idToken = googleAuth.idToken;
//
//       debugPrint("ID TOKEN ==========> $idToken");
//
//       // Get tokens using authorizationClient
//       final authorization = await googleUser.authorizationClient
//           .authorizationForScopes(['email', 'profile']);
//
//       // final idToken = googleUser.authentication.idToken;
//       final accessToken = authorization?.accessToken;
//
//       if (accessToken == null) {
//         throw FirebaseAuthException(
//             code: "ERROR_MISSING_ACCESS_TOKEN",
//             message: "Google access token is null");
//       }
//
//       final credential = GoogleAuthProvider.credential(
//         accessToken: accessToken,
//         idToken: idToken,
//       );
//
//       final userCredential = await _auth.signInWithCredential(credential);
//
//       final user = userCredential.user;
//       if (user != null) {
//         debugPrint("Firebase Login Success: ${user.email}");
//         await _loginWithFirebaseToAPI(user);
//       }
//       debugPrint(user.toString());
//       return userCredential;
//     } catch (e) {
//       debugPrint('Error: $e');
//       rethrow;
//     }
//   }
//
//   Future<void> signOut() async {
//     await _googleSignIn.signOut();
//     await _auth.signOut();
//   }
//   // ===============================
//   // SEND FIREBASE USER TO BACKEND
//   // ===============================
//   Future<void> _loginWithFirebaseToAPI(User user) async {
//     try {
//       final idToken = await user.getIdToken();
//
//       final response = await http.post(
//         Uri.parse("${_apiProvider.baseUrl}/api/user-auth.php"),
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode({
//           "login-user": "true",
//           "accesstoken": idToken,
//           "signin-type" : "200",
//           "account-type" : "1",
//           "gettoken": "0123456789"
//         }),
//       );
//
//       final data = jsonDecode(response.body);
//       status.value = data["status"] ?? "";
//       print("My Token ${idToken}");
//
//       if (response.statusCode == 200 && status.value == "success") {
//         final userId = data["response"]["userid"];
//         globalController.setValue(userId);
//         Get.offAllNamed(Routes.DASHBOARD);
//         Get.snackbar("Success", "Logged in successfully");
//       } else {
//         Get.snackbar("Login Failed", data["message"] ?? "Firebase login failed on API side");
//       }
//     } catch (e) {
//       Get.snackbar("Error", "API error after Firebase login: $e");
//     }
//   }
//   User? getCurrentUser() => _auth.currentUser;
//
//
//
//   Future<void> login({
//     required String email,
//     required String password,
//   }) async {
//     isLoading.value = true;
//
//     try {
//       final response = await http.post(
//         Uri.parse("${_apiProvider.baseUrl}/api/user-auth.php"),
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode({
//           "email": email,
//           "password": password,
//           "signin-type": "100",
//           "gettoken": "0123456789",
//           "login-user": "true"
//
//         }),
//       );
//
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final  Map<String, dynamic> data = jsonDecode(response.body);
//         status.value = data["status"] ?? '';
//
//         if( status.value  == "success" ){
//           debugPrint(const JsonEncoder.withIndent('  ').convert(data));
//
//           // Assuming setValue stores the UserId globally
//           final userId = data["response"]["userid"];
//           globalController.setValue(userId);
//           debugPrint("UserId : ${globalController.userId}");
//
//           emailController.clear();
//           passwordController.clear();
//
//           // Use Get.offAllNamed for navigation after a successful login
//           Get.offAllNamed(Routes.DASHBOARD);
//         }
//
//         debugPrint("API Login Status: ${status.value}");
//         Get.snackbar(status.value, data["response"]["message"] ?? "Login completed", snackPosition: SnackPosition.BOTTOM);
//
//       } else {
//         // Handle non-200 status codes
//         final error = jsonDecode(response.body);
//         Get.snackbar("Error", error["message"] ?? "Something went wrong during API login.", snackPosition: SnackPosition.BOTTOM);
//       }
//     } catch (e) {
//       // Handle network or JSON decoding errors
//       Get.snackbar("Error", "Network error or failed to process response: $e", snackPosition: SnackPosition.BOTTOM);
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }

import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:oyato_food/app/api_service/api_provider.dart';
import 'package:oyato_food/app/global_controller/global_controller.dart';
import 'package:oyato_food/app/routes/app_pages.dart';

class LogInController extends GetxController {
  // =========================
  // VARIABLES
  // =========================
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final ApiProvider _apiProvider = ApiProvider();
  final GlobalController globalController = Get.find<GlobalController>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final RxBool isLoading = false.obs;
  final RxString status = ''.obs;
  final RxString errorMessage = ''.obs;

  // =========================
  // MANUAL LOGIN
  // =========================
  Future<void> login({
    required String email,
    required String password,
  }) async {
    isLoading.value = true;

    try {
      final response = await http.post(
        Uri.parse("${_apiProvider.baseUrl}/api/user-auth.php"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
          "signin-type": "100", // Manual login type
          "gettoken": "0123456789",
          "login-user": "true"
        }),
      );

      final data = jsonDecode(response.body);
      status.value = data["status"] ?? "";

      if (response.statusCode == 200 && status.value == "success") {
        final userId = data["response"]["userid"];
        globalController.setValue(userId);

        emailController.clear();
        passwordController.clear();

        Get.offAllNamed(Routes.DASHBOARD);
        Get.snackbar("Success", data["response"]["message"] ?? "Login successful");
      } else {
        Get.snackbar("Login Failed", data["message"] ?? "Invalid credentials");
      }
    } catch (e) {
      Get.snackbar("Error", "Network error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // =========================
  // GOOGLE SIGN-IN + FIREBASE
  // =========================
  Future<UserCredential?> signInWithGoogle() async {
    try {

      // Begin sign in process
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        Get.snackbar("Cancelled", "Google sign-in cancelled by user");
        return null;
      }

      // Get Google auth details
      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with Firebase
      final UserCredential userCredential =
      await _auth.signInWithCredential(credential);

      final User? user = userCredential.user;
      if (user != null) {
        debugPrint("Firebase Login Success: ${user.email}");
        await _loginWithFirebaseToAPI(user,googleUser);
      }

      return userCredential;
    } catch (e) {
      debugPrint("Google Sign-In Error: $e");
      Get.snackbar("Error", "Failed to sign in with Google: $e");
      return null;
    }
  }

  // =========================
  // SEND FIREBASE USER TO BACKEND
  // =========================
  Future<void> _loginWithFirebaseToAPI(User user,GoogleSignInAccount googleUser) async {
    try {
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      if (accessToken == null) {
        Get.snackbar("Error", "Access token is null");
        return;
      }

      print("Google Access Token: $accessToken");

      final response = await http.post(
        Uri.parse("${_apiProvider.baseUrl}/api/user-auth.php"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "login-user": "true",
          "accesstoken": accessToken,
          "signin-type": "200", // Firebase login type
          "account-type": "1",
          "gettoken": "0123456789"
        }),
      );

      final data = jsonDecode(response.body);
      status.value = data["status"] ?? "";

      print("Api Hit");
      print("hsjadjasd: ${response}");
      print("Response: ${response.statusCode}");
      print("Body: ${response.body}");

      if (response.statusCode == 200 && status.value == "success") {
        final userId = data["response"]["userid"];
        globalController.setValue(userId);
        Get.offAllNamed(Routes.DASHBOARD);
        Get.snackbar("Success", "Logged in successfully");
      } else {
        Get.snackbar("API Login Failed",
            data["message"] ?? "Firebase login failed on API side");
      }
    } catch (e) {
      Get.snackbar("Error", "API error after Firebase login: $e");
    }
  }

  // =========================
  // SIGN OUT (GOOGLE + FIREBASE)
  // =========================
  Future<void> signOut() async {
    await _googleSignIn.disconnect();
    await _googleSignIn.signOut();
    await _auth.signOut();
    Get.snackbar("Logged Out", "You have been signed out successfully");
  }

  // =========================
  // HELPER
  // =========================
  User? getCurrentUser() => _auth.currentUser;
}
