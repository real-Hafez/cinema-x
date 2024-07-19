import 'package:cinema_x/Splash_screen/widgets/slide_Image_anim.dart';
import 'package:cinema_x/Splash_screen/widgets/sliding_text.dart';
import 'package:cinema_x/Splash_screen/widgets/slogan_text.dart';
import 'package:flutter/material.dart';

class SlideImageAnimationant_Text extends StatelessWidget {
  const SlideImageAnimationant_Text({
    super.key,
    required AnimationController controller,
    required bool showFirstAnimation,
    required Animation<double> scaleAnimation,
    required Animation<Offset> slideAnimation,
    required Animation<Offset> textSlideAnimation,
    required AnimationController sloganController,
    required Animation<Offset> SloganAnimation,
  }) : _controller = controller, _showFirstAnimation = showFirstAnimation, _scaleAnimation = scaleAnimation, _slideAnimation = slideAnimation, _textSlideAnimation = textSlideAnimation, _sloganController = sloganController, _SloganAnimation = SloganAnimation;

  final AnimationController _controller;
  final bool _showFirstAnimation;
  final Animation<double> _scaleAnimation;
  final Animation<Offset> _slideAnimation;
  final Animation<Offset> _textSlideAnimation;
  final AnimationController _sloganController;
  final Animation<Offset> _SloganAnimation;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: SlideImageAnimation(
                  controller: _controller,
                  showFirstAnimation: _showFirstAnimation,
                  scaleAnimation: _scaleAnimation,
                  slideAnimation: _slideAnimation,
                ),
              ),
              sliding_text(
                sliding_anim: _textSlideAnimation,
              ),
            ],
          ),
          const SizedBox(height: 20),
          AnimatedBuilder(
            animation: _sloganController,
            builder: (context, child) {
              return Transform.translate(
                offset: _SloganAnimation.value,
                child: slogan_text(SloganAnimation: _SloganAnimation),
              );
            },
          ),
        ],
      ),
    );
  }
}
