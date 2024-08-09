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
    apiKey: 'AIzaSyCAGbXQDXAtuU_zKXU_y0Yc9eYwgbwXO0c',
    appId: '1:679633769638:web:00c301ef898bd06b689067',
    messagingSenderId: '679633769638',
    projectId: 'todo-79613',
    authDomain: 'todo-79613.firebaseapp.com',
    storageBucket: 'todo-79613.appspot.com',
    measurementId: 'G-W51E0N346L',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBrPoEE3lSzP2bw_OCgFHOzRtnY9-i-pD4',
    appId: '1:679633769638:android:32401e45d51af68d689067',
    messagingSenderId: '679633769638',
    projectId: 'todo-79613',
    storageBucket: 'todo-79613.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDNY8oIFxHYilklvLiNsOgvOG8bpH64VVk',
    appId: '1:679633769638:ios:9e75f9325ffa8956689067',
    messagingSenderId: '679633769638',
    projectId: 'todo-79613',
    storageBucket: 'todo-79613.appspot.com',
    iosBundleId: 'com.example.todoApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDNY8oIFxHYilklvLiNsOgvOG8bpH64VVk',
    appId: '1:679633769638:ios:9e75f9325ffa8956689067',
    messagingSenderId: '679633769638',
    projectId: 'todo-79613',
    storageBucket: 'todo-79613.appspot.com',
    iosBundleId: 'com.example.todoApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCAGbXQDXAtuU_zKXU_y0Yc9eYwgbwXO0c',
    appId: '1:679633769638:web:86091d47663e07d2689067',
    messagingSenderId: '679633769638',
    projectId: 'todo-79613',
    authDomain: 'todo-79613.firebaseapp.com',
    storageBucket: 'todo-79613.appspot.com',
    measurementId: 'G-46HS2NRDY6',
  );
}
