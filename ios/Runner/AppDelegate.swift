import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
      GMSServices.provideAPIKey("AIzaSyBK4_wkGR5-S1WtI7k2jRAKRyENBmO2a1o")
      GeneratedPluginRegistrant.register(with: self)
        if #available(iOS 10.0, *)
        {
         UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate

         }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
