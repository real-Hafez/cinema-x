import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class ForYouPopular extends StatelessWidget {
  const ForYouPopular({super.key, required this.textForRowOrMovie});
  final String textForRowOrMovie;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .05,
      width: double.infinity,
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
                  TypewriterAnimatedText(
                    textForRowOrMovie,
                    textStyle: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * .07,
                      fontWeight: FontWeight.bold,
                      color: Colors.orangeAccent,
                    ),
                    speed: const Duration(milliseconds: 150),
                  ),
                  TypewriterAnimatedText(
                    'Trending People!',
                    textStyle: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * .07,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                    speed: const Duration(milliseconds: 150),
                  ),
                  TypewriterAnimatedText(
                    'Check out who\'s trending now!',
                    textStyle: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * .06,
                      fontWeight: FontWeight.bold,
                      color: Colors.greenAccent,
                    ),
                    speed: const Duration(milliseconds: 150),
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
    );
  }
}
