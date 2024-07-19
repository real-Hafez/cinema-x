import 'dart:async';

import 'package:cinema_x/Splash_screen/screen/splash_screen.dart';
import 'package:cinema_x/firebase_options.dart';
import 'package:device_preview/device_preview.dart';
// import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// void main() => runApp(
//       DevicePreview(
//         backgroundColor: Colors.red,
//         enabled: !kReleaseMode,
//         builder: (context) => const CinemaX(), // Wrap your app
//       ),
//     );

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    DevicePreview(
      builder: (context) => const CinemaX(),
    ),
  );
}

class CinemaX extends StatelessWidget {
  const CinemaX({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        fontFamily: 'SFProDisplay',
      ),
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Cinema X',
      home: const SplashScreen(),
    );
  }
}
