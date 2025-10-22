import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

import '../global_controller/global_controller.dart';

class MonerisWebView extends StatefulWidget {
  const MonerisWebView({super.key});

  @override
  State<MonerisWebView> createState() => _MonerisWebViewState();
}

class _MonerisWebViewState extends State<MonerisWebView> {
  late final WebViewController _controller;
  bool _isLoading = true;
  String userId = "";

  @override
  void initState() {
    super.initState();
    GlobalController globalController = Get.find<GlobalController>();
    userId = globalController.userId.value;
    // Create platform-specific params
    final PlatformWebViewControllerCreationParams params =
    defaultTargetPlatform == TargetPlatform.android
        ?  AndroidWebViewControllerCreationParams()
        : const PlatformWebViewControllerCreationParams();

    _controller = WebViewController.fromPlatformCreationParams(params);

    // Android-specific hybrid composition
    if (_controller.platform is AndroidWebViewController) {
      final androidController = _controller.platform as AndroidWebViewController;
      AndroidWebViewController.enableDebugging(true);
      androidController.setMediaPlaybackRequiresUserGesture(false);
      // Hybrid composition is automatically used in 4.x, no need to set
    }

    _controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) => setState(() => _isLoading = true),
          onPageFinished: (url) => setState(() => _isLoading = false),
          onWebResourceError: (error) {
            debugPrint('WebView error: ${error.description}');
          },
        ),
      )
      ..loadRequest(Uri.parse('https://www.moneris.com'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            WebViewWidget(
            controller: _controller
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..addJavaScriptChannel(
            'MonerisFlutterChannel',
            onMessageReceived: (JavaScriptMessage message) {
              // STEP 2: Intercept the message containing the token
              _handleMonerisToken(message.message);
            },
          )
          ..loadRequest(Uri.parse('YOUR_MONERIS_HT_URL_WITH_PROFILE_ID')),
      ),
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
          ],
        ),
      ),
    );
  }
  Future<void> _sendTokenToBackend(String temporaryToken) async {
    const String backendUrl = 'https://oyatofood.com//api/order.php';
    final String amount = "10.99"; // Get actual amount

    try {
      final response = await http.post(
        Uri.parse(backendUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          // Add any necessary authorization headers for your backend
        },
        body: jsonEncode(<String, dynamic>{
          "order": "bill-pay",
          "userid": userId,
          "method": "2",
          "pay-card":"true",
          "pay-amount" : amount,
          "ticketNumber" : temporaryToken,
          "gettoken": "0123456789"
        }),
      );

      if (response.statusCode == 200) {
        // Success! Payment processed.
        print('Payment Successful. Backend response: ${response.body}');
      } else {
        // Failure from your backend (e.g., Moneris charge failed)
        print('Payment failed. Status: ${response.statusCode}, Body: ${response.body}');
      }
    } catch (e) {
      print('Error sending data to backend: $e');
    }
  }
  void _handleMonerisToken(String responseJsonString) {
    // Parse the JSON string from the webview message
    // You might need to adjust the parsing based on how Moneris's HPP
    // is configured to send the response.
    Map<String, dynamic> responseData = json.decode(responseJsonString);
    String temporaryToken = responseData['dataKey'];

    // STEP 3: Call your backend API to process the charge
    _sendTokenToBackend(temporaryToken);


  }

}




