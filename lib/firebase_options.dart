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
    apiKey: 'AIzaSyCzMGDqxdQef39VrJamK_he-d2bge4lMXo',
    appId: '1:83886421277:web:5d665f471e7f133441ddf4',
    messagingSenderId: '83886421277',
    projectId: 'talkaro-messenger-6685a',
    authDomain: 'talkaro-messenger-6685a.firebaseapp.com',
    storageBucket: 'talkaro-messenger-6685a.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAbRHEWLc6Sw5X09i0zl4VcSkexUnv4-yc',
    appId: '1:83886421277:android:8f0b896a88cc681341ddf4',
    messagingSenderId: '83886421277',
    projectId: 'talkaro-messenger-6685a',
    storageBucket: 'talkaro-messenger-6685a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCPMVzYPhqPXHYhWiJph_uuxle7_FXUnOI',
    appId: '1:83886421277:ios:f534f7a8be3c6d2241ddf4',
    messagingSenderId: '83886421277',
    projectId: 'talkaro-messenger-6685a',
    storageBucket: 'talkaro-messenger-6685a.appspot.com',
    iosClientId: '83886421277-fg5levkbv8lurn2ltl8u7u1sroaaf49q.apps.googleusercontent.com',
    iosBundleId: 'com.example.talkaro',
  );
}
