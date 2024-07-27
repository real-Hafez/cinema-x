import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class ForYouPopular_movies extends StatefulWidget {
  const ForYouPopular_movies(
      {super.key,
      required this.textForRowOrMovie,
      required this.textnumber2,
      required this.textnumber3});
  final String textForRowOrMovie;
  final String textnumber2;
  final String textnumber3;

  @override
  _ForYouPopular_moviesState createState() => _ForYouPopular_moviesState();
}

class _ForYouPopular_moviesState extends State<ForYouPopular_movies> {
  final List<Color> _colors = [
    Colors.blueAccent,
    Colors.purpleAccent,
    Colors.redAccent,
    Colors.orangeAccent,
    Colors.greenAccent,
  ];

  int _currentIndex = 0;
  late List<Color> _gradientColors;
  late Future<void> _colorAnimationFuture;

  @override
  void initState() {
    super.initState();
    _gradientColors = _colors.sublist(0, 2);
    _startColorAnimation();
  }

  void _startColorAnimation() {
    _colorAnimationFuture = Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % (_colors.length - 1);
          _gradientColors = _colors.sublist(_currentIndex, _currentIndex + 2);
        });
        _startColorAnimation(); // Continue animation
      }
    });
  }

  @override
  void dispose() {
    // Handle cancellation if needed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * .03),
      child: Container(
        height: MediaQuery.of(context).size.height * .1,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: _gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * .02,
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    FadeAnimatedText(
                      widget.textForRowOrMovie,
                      textStyle: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * .07,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      duration: const Duration(seconds: 2),
                    ),
                    FadeAnimatedText(
                      widget.textnumber2,
                      textStyle: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * .07,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      duration: const Duration(seconds: 2),
                    ),
                    FadeAnimatedText(
                      widget.textnumber3,
                      textStyle: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * .055,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      duration: const Duration(seconds: 2),
                    ),
                  ],
                  isRepeatingAnimation: true,
                  repeatForever: true,
                  displayFullTextOnTap: true,
                  stopPauseOnTap: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
