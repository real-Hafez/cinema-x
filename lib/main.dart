import 'dart:async';
import 'dart:ui';
import 'package:cinema_x/Splash_screen/screen/splash_screen.dart';
import 'package:cinema_x/firebase_options.dart';
import 'package:cinema_x/for_you_row/service/for_you_service_movies.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );

  final forYouService = for_you_service_movies();

  await forYouService.printUserEmail();

  // Fetch movies only after ensuring favorite genres are loaded
  if (forYouService.Fav_movies_list.isNotEmpty) {
    await forYouService.fetchMovies(1);
  } else {
    print('No favorite genres available to fetch movies.');
  }

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

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
        primaryColor: const Color(
          (0xff090E17),
        ),
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
