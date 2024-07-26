import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class for_you_row_body extends StatelessWidget {
  const for_you_row_body({super.key, required this.text_for_row_or_movie});
  final String text_for_row_or_movie;

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
                  ColorizeAnimatedText(
                    text_for_row_or_movie,
                    textStyle: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * .07,
                      fontWeight: FontWeight.bold,
                    ),
                    colors: [
                      Colors.white,
                      Colors.red,
                      Colors.green,
                      Colors.blue,
                      Colors.yellow,
                      Colors.orange,
                      Colors.purple,
                      Colors.pink,
                      Colors.cyan,
                      Colors.lime,
                    ],
                    speed: const Duration(milliseconds: 1000),
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
