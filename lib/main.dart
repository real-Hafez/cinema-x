import 'dart:async';
import 'dart:ui';
import 'package:cinema_x/Splash_screen/screen/splash_screen.dart';
import 'package:cinema_x/firebase_options.dart';
import 'package:cinema_x/for_you_row/service/for_you_service_movies.dart';
import 'package:cinema_x/for_you_row/service/for_you_service_series.dart';
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

  final forYouServiceseries = for_you_service_series();
  await forYouServiceseries.printUserEmail();

  if (forYouService.favMoviesList.isNotEmpty) {
    await forYouService.fetchMovies(1);
  } else {}
  if (forYouServiceseries.Fav_series_list.isNotEmpty) {
    await forYouServiceseries.fetchseries(1);
  } else {}
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
      debugShowCheckedModeBanner: false,
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
