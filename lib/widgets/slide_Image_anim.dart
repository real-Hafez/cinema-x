import 'package:flutter/material.dart';

class SlideImageAnimation extends StatelessWidget {
  final AnimationController controller;
  final bool showFirstAnimation;
  final Animation<double> scaleAnimation;
  final Animation<Offset> slideAnimation;

  const SlideImageAnimation({
    super.key,
    required this.controller,
    required this.showFirstAnimation,
    required this.scaleAnimation,
    required this.slideAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        if (showFirstAnimation) {
          return ScaleTransition(
            scale: scaleAnimation,
            child: Image.asset(
              'assets/Images/android-chrome-512x512.png',
            ),
          );
        } else {
          return Transform.scale(
            scale: 0.7,
            child: SlideTransition(
              position: slideAnimation,
              child: Image.asset(
                'assets/Images/android-chrome-512x512.png',
              ),
            ),
          );
        }
      },
    );
  }
}
