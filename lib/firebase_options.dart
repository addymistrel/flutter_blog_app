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
        return windows;
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
    apiKey: 'AIzaSyB0uidWZRa9Av3BhtyCvXB4JzlHfq3_Si8',
    appId: '1:360767054254:web:3932b8a6e12cc7657a283f',
    messagingSenderId: '360767054254',
    projectId: 'flutter-blog-app-addymistrel',
    authDomain: 'flutter-blog-app-addymistrel.firebaseapp.com',
    storageBucket: 'flutter-blog-app-addymistrel.firebasestorage.app',
    measurementId: 'G-V4CGXQL0H0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDDoM76y-srmW7x0_82YndBp83TFUiZ1Qc',
    appId: '1:360767054254:android:f9451ac4a94bcc437a283f',
    messagingSenderId: '360767054254',
    projectId: 'flutter-blog-app-addymistrel',
    storageBucket: 'flutter-blog-app-addymistrel.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC793ii0CZ--JI_v-2YzZWzD4O-6tTEVcY',
    appId: '1:360767054254:ios:18706e96a10670957a283f',
    messagingSenderId: '360767054254',
    projectId: 'flutter-blog-app-addymistrel',
    storageBucket: 'flutter-blog-app-addymistrel.firebasestorage.app',
    iosBundleId: 'com.example.flutterBlogApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC793ii0CZ--JI_v-2YzZWzD4O-6tTEVcY',
    appId: '1:360767054254:ios:18706e96a10670957a283f',
    messagingSenderId: '360767054254',
    projectId: 'flutter-blog-app-addymistrel',
    storageBucket: 'flutter-blog-app-addymistrel.firebasestorage.app',
    iosBundleId: 'com.example.flutterBlogApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB0uidWZRa9Av3BhtyCvXB4JzlHfq3_Si8',
    appId: '1:360767054254:web:f347c98fe57fa4e27a283f',
    messagingSenderId: '360767054254',
    projectId: 'flutter-blog-app-addymistrel',
    authDomain: 'flutter-blog-app-addymistrel.firebaseapp.com',
    storageBucket: 'flutter-blog-app-addymistrel.firebasestorage.app',
    measurementId: 'G-2BEXJG2S7K',
  );
}
