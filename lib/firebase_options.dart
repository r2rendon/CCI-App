// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB5EZcZkiiohBETwJOHq1FZfZas7UM0sec',
    appId: '1:627466444740:web:996d6ae3b56825d6fd8e91',
    messagingSenderId: '627466444740',
    projectId: 'cci-app-8ad55',
    authDomain: 'cci-app-8ad55.firebaseapp.com',
    databaseURL: 'https://cci-app-8ad55-default-rtdb.firebaseio.com',
    storageBucket: 'cci-app-8ad55.appspot.com',
    measurementId: 'G-S8TZ1PQW6K',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAfiq2nd1_vNicOPDRX1Jx2fIU7IfEtzMQ',
    appId: '1:627466444740:android:ef1bb2949a15ec7ffd8e91',
    messagingSenderId: '627466444740',
    projectId: 'cci-app-8ad55',
    databaseURL: 'https://cci-app-8ad55-default-rtdb.firebaseio.com',
    storageBucket: 'cci-app-8ad55.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCUdv8i8E35QB2dnecbtpZVSCr9GrKSn2k',
    appId: '1:627466444740:ios:5ac27b4b7c39e81bfd8e91',
    messagingSenderId: '627466444740',
    projectId: 'cci-app-8ad55',
    databaseURL: 'https://cci-app-8ad55-default-rtdb.firebaseio.com',
    storageBucket: 'cci-app-8ad55.appspot.com',
    iosBundleId: 'com.example.cciApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCUdv8i8E35QB2dnecbtpZVSCr9GrKSn2k',
    appId: '1:627466444740:ios:5ac27b4b7c39e81bfd8e91',
    messagingSenderId: '627466444740',
    projectId: 'cci-app-8ad55',
    databaseURL: 'https://cci-app-8ad55-default-rtdb.firebaseio.com',
    storageBucket: 'cci-app-8ad55.appspot.com',
    iosBundleId: 'com.example.cciApp',
  );
}
