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
    apiKey: 'AIzaSyBP7Ejq9YYpFRin8tQONVmjzEtJRpdJG0Y',
    appId: '1:754889930533:web:232bee4ec4decd18f44ccc',
    messagingSenderId: '754889930533',
    projectId: 'quickfood-bfd75',
    authDomain: 'quickfood-bfd75.firebaseapp.com',
    storageBucket: 'quickfood-bfd75.appspot.com',
    measurementId: 'G-GNXWME3YGF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD3N0TS-Aq_BXc0N86Rj8TMPO3J_oR4pbM',
    appId: '1:754889930533:android:9575f7cf33f80505f44ccc',
    messagingSenderId: '754889930533',
    projectId: 'quickfood-bfd75',
    storageBucket: 'quickfood-bfd75.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC4WzQYtPVVPDNZV-t2lXLLU4seIC4892Q',
    appId: '1:754889930533:ios:358e3068460d6135f44ccc',
    messagingSenderId: '754889930533',
    projectId: 'quickfood-bfd75',
    storageBucket: 'quickfood-bfd75.appspot.com',
    iosBundleId: 'com.example.snackTime',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC4WzQYtPVVPDNZV-t2lXLLU4seIC4892Q',
    appId: '1:754889930533:ios:358e3068460d6135f44ccc',
    messagingSenderId: '754889930533',
    projectId: 'quickfood-bfd75',
    storageBucket: 'quickfood-bfd75.appspot.com',
    iosBundleId: 'com.example.snackTime',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBP7Ejq9YYpFRin8tQONVmjzEtJRpdJG0Y',
    appId: '1:754889930533:web:c89e399dfaebf004f44ccc',
    messagingSenderId: '754889930533',
    projectId: 'quickfood-bfd75',
    authDomain: 'quickfood-bfd75.firebaseapp.com',
    storageBucket: 'quickfood-bfd75.appspot.com',
    measurementId: 'G-KF5E0WXY27',
  );
}
