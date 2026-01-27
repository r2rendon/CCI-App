import UIKit
import Flutter
import FirebaseCore
import FirebaseMessaging
import UserNotifications

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Registrar plugins primero (esto inicializa Firebase automáticamente)
    GeneratedPluginRegistrant.register(with: self)
    
    // Configurar notificaciones push después de registrar plugins
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self
      let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
      UNUserNotificationCenter.current().requestAuthorization(
        options: authOptions,
        completionHandler: { _, _ in }
      )
    } else {
      let settings: UIUserNotificationSettings =
        UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
      application.registerUserNotificationSettings(settings)
    }
    
    // Registrar para notificaciones remotas (requiere APNs configurado en Firebase)
    application.registerForRemoteNotifications()
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  // Manejar el registro de notificaciones remotas
  override func application(_ application: UIApplication,
                           didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    // Configurar APNs token en Firebase
    if FirebaseApp.app() != nil {
      Messaging.messaging().apnsToken = deviceToken
    }
  }
  
  // Manejar errores al registrar notificaciones remotas
  override func application(_ application: UIApplication,
                           didFailToRegisterForRemoteNotificationsWithError error: Error) {
    // Esto es normal si APNs no está configurado en Firebase
    print("Error registrando notificaciones remotas: \(error.localizedDescription)")
  }
}
