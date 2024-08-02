import 'dart:async';
import 'package:cinema_x/Splash_screen/widgets/Splash_Screen_body.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _hasInternetConnection = false;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
  }

  Future<void> _checkConnectivity() async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      setState(() {
        _hasInternetConnection = connectivityResult != ConnectivityResult.none;
      });

      // Navigate based on connectivity status
      Timer(
        const Duration(seconds: 2),
        () {
          if (_hasInternetConnection) {
          } else {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const NoInternetScreen(),
              ),
            );
          }
        },
      );
    } catch (e) {
      setState(() {
        _hasInternetConnection = false;
      });
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const NoInternetScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xff090E17),
      body: Splash_Screen_body(),
    );
  }
}

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xff090E17),
      body: Center(
        child: Text(
          'No internet connection',
          style: TextStyle(fontSize: 18, color: Colors.red),
        ),
      ),
    );
  }
}
