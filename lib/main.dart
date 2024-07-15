import 'package:flutter/material.dart';

void main() {
  runApp(const CinemaX());
}

class CinemaX extends StatelessWidget {
  const CinemaX({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Cinema X',
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
