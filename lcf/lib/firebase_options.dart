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
    apiKey: 'AIzaSyCd4-BeWnLt2MEX2GaIIwmETZPhkqfEj2c',
    appId: '1:939919517768:web:305afa37d5c2c05427107d',
    messagingSenderId: '939919517768',
    projectId: 'lcfdatabase',
    authDomain: 'lcfdatabase.firebaseapp.com',
    storageBucket: 'lcfdatabase.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDEIsNmpV1hKYk3lGcHXcQhtwHyrBzu7YU',
    appId: '1:939919517768:android:133e44cd09ca95cf27107d',
    messagingSenderId: '939919517768',
    projectId: 'lcfdatabase',
    storageBucket: 'lcfdatabase.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCgYy-e9yk4cYYxYtytgI_AFdeHM3Ab-V4',
    appId: '1:939919517768:ios:f69ef94cda8c140927107d',
    messagingSenderId: '939919517768',
    projectId: 'lcfdatabase',
    storageBucket: 'lcfdatabase.appspot.com',
    iosClientId: '939919517768-m4crrdtr1t53fpp3ano4dutjvlun142i.apps.googleusercontent.com',
    iosBundleId: 'com.example.lcf',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCgYy-e9yk4cYYxYtytgI_AFdeHM3Ab-V4',
    appId: '1:939919517768:ios:f69ef94cda8c140927107d',
    messagingSenderId: '939919517768',
    projectId: 'lcfdatabase',
    storageBucket: 'lcfdatabase.appspot.com',
    iosClientId: '939919517768-m4crrdtr1t53fpp3ano4dutjvlun142i.apps.googleusercontent.com',
    iosBundleId: 'com.example.lcf',
  );
}
