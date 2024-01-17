// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
    apiKey: 'AIzaSyCH2TSLliiFsQi3lteEzDa7ZS6WWoM-MrM',
    appId: '1:816413409410:web:c2ff4df5ff79a88788349b',
    messagingSenderId: '816413409410',
    projectId: 'mobilproje-3e1a8',
    authDomain: 'mobilproje-3e1a8.firebaseapp.com',
    storageBucket: 'mobilproje-3e1a8.appspot.com',
    measurementId: 'G-59RV384Q07',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDIJOjc-Ix03iHAz8tHZ3ceeiFNAlHfxqI',
    appId: '1:816413409410:android:7feac7159a05af3788349b',
    messagingSenderId: '816413409410',
    projectId: 'mobilproje-3e1a8',
    storageBucket: 'mobilproje-3e1a8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBVz8-9i02yZqnE8zfOyvjseyT1zxb1Zhg',
    appId: '1:816413409410:ios:0702480e1f271f2688349b',
    messagingSenderId: '816413409410',
    projectId: 'mobilproje-3e1a8',
    storageBucket: 'mobilproje-3e1a8.appspot.com',
    iosBundleId: 'com.example.mobilproje',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBVz8-9i02yZqnE8zfOyvjseyT1zxb1Zhg',
    appId: '1:816413409410:ios:fbe9fdf91630a0b688349b',
    messagingSenderId: '816413409410',
    projectId: 'mobilproje-3e1a8',
    storageBucket: 'mobilproje-3e1a8.appspot.com',
    iosBundleId: 'com.example.mobilproje.RunnerTests',
  );
}
