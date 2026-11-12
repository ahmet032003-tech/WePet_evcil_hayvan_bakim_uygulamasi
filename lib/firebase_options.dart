import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
/// Configured for project `bitirme-projesi-ec756`.
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
      default:
        return web;
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCEsIyHFkI203eN6nKTCn61bnudMZYn0rQ',
    appId: '1:445830677341:web:05607f9e36dbf15c241eb4',
    messagingSenderId: '445830677341',
    projectId: 'bitirme-projesi-ec756',
    authDomain: 'bitirme-projesi-ec756.firebaseapp.com',
    storageBucket: 'bitirme-projesi-ec756.firebasestorage.app',
    measurementId: 'G-M0QQ01RV4L',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCEsIyHFkI203eN6nKTCn61bnudMZYn0rQ',
    appId: '1:445830677341:android:05607f9e36dbf15c241eb4',
    messagingSenderId: '445830677341',
    projectId: 'bitirme-projesi-ec756',
    storageBucket: 'bitirme-projesi-ec756.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCEsIyHFkI203eN6nKTCn61bnudMZYn0rQ',
    appId: '1:445830677341:ios:05607f9e36dbf15c241eb4',
    messagingSenderId: '445830677341',
    projectId: 'bitirme-projesi-ec756',
    storageBucket: 'bitirme-projesi-ec756.firebasestorage.app',
    iosBundleId: 'com.wepet.app',
  );
}
