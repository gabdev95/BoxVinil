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
    apiKey: 'AIzaSyBM2iAYnIE3VnH0PD0ZirWPLavcO39Viyw',
    appId: '1:402694438233:web:881bc8c69e7a4322c8a048',
    messagingSenderId: '402694438233',
    projectId: 'box-vinil-619c3',
    authDomain: 'box-vinil-619c3.firebaseapp.com',
    databaseURL: 'https://box-vinil-619c3-default-rtdb.firebaseio.com',
    storageBucket: 'box-vinil-619c3.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDNCLI9xECty4sNYWV-C0JC3UwvU6uQSyo',
    appId: '1:402694438233:android:899491e63fd4f36ac8a048',
    messagingSenderId: '402694438233',
    projectId: 'box-vinil-619c3',
    databaseURL: 'https://box-vinil-619c3-default-rtdb.firebaseio.com',
    storageBucket: 'box-vinil-619c3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB37MburTmodETagurwqA5SqIh_T7px0xw',
    appId: '1:402694438233:ios:b0e1e858502d0d89c8a048',
    messagingSenderId: '402694438233',
    projectId: 'box-vinil-619c3',
    databaseURL: 'https://box-vinil-619c3-default-rtdb.firebaseio.com',
    storageBucket: 'box-vinil-619c3.appspot.com',
    iosClientId:
        '402694438233-sqs1e9ghnbhe661bj8pn2pa1b7trkqrd.apps.googleusercontent.com',
    iosBundleId: 'com.example.projectBoxvinil',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB37MburTmodETagurwqA5SqIh_T7px0xw',
    appId: '1:402694438233:ios:b0e1e858502d0d89c8a048',
    messagingSenderId: '402694438233',
    projectId: 'box-vinil-619c3',
    databaseURL: 'https://box-vinil-619c3-default-rtdb.firebaseio.com',
    storageBucket: 'box-vinil-619c3.appspot.com',
    iosClientId:
        '402694438233-sqs1e9ghnbhe661bj8pn2pa1b7trkqrd.apps.googleusercontent.com',
    iosBundleId: 'com.example.projectBoxvinil',
  );
}
