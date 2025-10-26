import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MonerisCheckoutController extends GetxController {
  late final WebViewController webViewController;
  var isLoading = true.obs;

  void initWebView(String checkoutId, String environment) {
    // Determine proper base URL
    String baseUrl;
    if (environment == "production") {
      baseUrl = "https://www3.moneris.com";
    } else {
      // Default to test (gatewayt)
      baseUrl = "https://gatewayt.moneris.com";
    }

    final url = '$baseUrl/chkt/$checkoutId';

    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) => isLoading.value = true,
          onPageFinished: (url) => isLoading.value = false,
          onNavigationRequest: (request) {
            final navUrl = request.url;

            if (navUrl.contains('success')) {
              print("Payment success ✅");
              Get.back(result: 'success');
              return NavigationDecision.prevent;
            } else if (navUrl.contains('cancel')) {
              print("Payment canceled ❌");
              Get.back(result: 'cancel');
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
          onWebResourceError: (error) {
            debugPrint('❗ WebView Error: ${error.description}');
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
  }
}

class MonerisCheckoutPage extends StatelessWidget {
  final String checkoutId;
  final String environment;

  MonerisCheckoutPage({
    super.key,
    required this.checkoutId,
    required this.environment,
  });

  final MonerisCheckoutController controller =
  Get.put(MonerisCheckoutController());

  @override
  Widget build(BuildContext context) {
    controller.initWebView(checkoutId, environment);

    return Scaffold(
      appBar: AppBar(title: const Text('Secure Moneris Payment')),
      body: Obx(() => Stack(
        children: [
          WebViewWidget(controller: controller.webViewController),
          if (controller.isLoading.value)
            const Center(child: CircularProgressIndicator()),
        ],
      )),
    );
  }
}
