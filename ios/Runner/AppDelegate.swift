import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyDwSBNYfoyyAX-7foRTUXEO1j8P0V0D2d4")
    GMSPlacesClient.provideAPIKey("AIzaSyDwSBNYfoyyAX-7foRTUXEO1j8P0V0D2d4")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
