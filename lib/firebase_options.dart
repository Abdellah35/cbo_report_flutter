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
    apiKey: 'AIzaSyCq76aoZQrbskvfZiTRwHi4S-OFc2DVkIk',
    appId: '1:108784377998:web:7e3350e6c281241b9ea9df',
    messagingSenderId: '108784377998',
    projectId: 'daily-report-152db',
    authDomain: 'daily-report-152db.firebaseapp.com',
    storageBucket: 'daily-report-152db.appspot.com',
    measurementId: 'G-8S7B86WK89',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCCg7wMlqUJuMkh_17HhuwC0oD8CiscVGw',
    appId: '1:108784377998:android:b8a1fddc526343379ea9df',
    messagingSenderId: '108784377998',
    projectId: 'daily-report-152db',
    storageBucket: 'daily-report-152db.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyApMW_uZ3_keVVlOAxT-mWPC5e-SBSiSE4',
    appId: '1:108784377998:ios:3cce2b8275b247639ea9df',
    messagingSenderId: '108784377998',
    projectId: 'daily-report-152db',
    storageBucket: 'daily-report-152db.appspot.com',
    iosBundleId: 'com.example.reportCbo',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyApMW_uZ3_keVVlOAxT-mWPC5e-SBSiSE4',
    appId: '1:108784377998:ios:c563a59428bfdc359ea9df',
    messagingSenderId: '108784377998',
    projectId: 'daily-report-152db',
    storageBucket: 'daily-report-152db.appspot.com',
    iosBundleId: 'com.example.reportCbo.RunnerTests',
  );
}
