import 'package:cinema_x/Splash_screen/screen/splash_screen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() => runApp(
      DevicePreview(
        backgroundColor: Colors.red,
        enabled: !kReleaseMode,
        builder: (context) => const CinemaX(), // Wrap your app
      ),
    );

// void main() {
//   runApp(const CinemaX());
// }

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
