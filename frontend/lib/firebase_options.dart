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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBV1Fuk8kWBJOkWwcTAbYiE4YuUEUFnSxk',
    appId: '1:115201145543:web:1bf8ae074eca5a68609ce2',
    messagingSenderId: '115201145543',
    projectId: 'moyeo-project',
    authDomain: 'moyeo-project.firebaseapp.com',
    storageBucket: 'moyeo-project.appspot.com',
    measurementId: 'G-VRC3JDQ7GD',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA7r8MRYyILuHyk2sp3rK0J9mU9zyfGu8Y',
    appId: '1:115201145543:android:f231571ff038281b609ce2',
    messagingSenderId: '115201145543',
    projectId: 'moyeo-project',
    storageBucket: 'moyeo-project.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC64W34PmLLeyAd6gbHylzI0PtFQQRedAQ',
    appId: '1:115201145543:ios:88d363b2b4946b0b609ce2',
    messagingSenderId: '115201145543',
    projectId: 'moyeo-project',
    storageBucket: 'moyeo-project.appspot.com',
    iosClientId: '115201145543-sudkp0tdht98artr66q89lqfgfpdvpja.apps.googleusercontent.com',
    iosBundleId: 'com.danim.danim',
  );
}
