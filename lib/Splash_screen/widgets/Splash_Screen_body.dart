import 'package:audioplayers/audioplayers.dart';
import 'package:cinema_x/HomeView.dart';
import 'package:cinema_x/Splash_screen/widgets/slide_Image_anim.dart';
import 'package:cinema_x/Splash_screen/widgets/sliding_text.dart';
import 'package:cinema_x/Splash_screen/widgets/slogan_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splash_Screen_body extends StatefulWidget {
  const Splash_Screen_body({super.key});

  @override
  _Splash_Screen_bodyState createState() => _Splash_Screen_bodyState();
}

class _Splash_Screen_bodyState extends State<Splash_Screen_body>
    with TickerProviderStateMixin {
  late AudioPlayer _audioPlayer;

  late AnimationController _controller;
  late AnimationController _textController;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<Offset> _textSlideAnimation;
  late AnimationController _sloganController;
  late Animation<Offset> _SloganAnimation;

  bool _showFirstAnimation = true;

  @override
  void initState() {
    super.initState();

    _audioPlayer = AudioPlayer(); // Initialize _audioPlayer

    Future.delayed(
      const Duration(seconds: 0),
      () {
        _playSound();
      },
    );
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _sloganController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Get.to(
          () => const Homeview(),
          transition: Transition.fade,
        );
      },
    );

    _scaleAnimation = Tween<double>(begin: 3.0, end: 0.7).animate(_controller);
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0, 0))
            .animate(_controller);
    _textController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _textSlideAnimation =
        Tween<Offset>(begin: const Offset(3.5, 0), end: const Offset(-0.2, 0))
            .animate(_textController);
    _controller.forward().whenComplete(() {
      setState(() {
        _showFirstAnimation = false;
      });
      _controller.reset();
      _controller.duration = const Duration(milliseconds: 10);

      _controller.forward().whenComplete(
        () {
          setState(() {
            _textController.forward();
          });
        },
      );
    });

    _SloganAnimation =
        Tween<Offset>(begin: const Offset(-5, 0), end: const Offset(0, 0))
            .animate(_sloganController);

    // Start slogan animation
    _sloganController.forward();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _controller.dispose();
    _textController.dispose();
    _sloganController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Row containing main content
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
          // Spacer to create space between Row and slogan_text
          const SizedBox(height: 20),
          // slogan_text widget with animated offset
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

  Future<void> _playSound() async {
    try {
      await _audioPlayer.play(
        volume: 0.7,
        AssetSource('sounds/app opening - Sound Effect.mp3'),
      );
    } catch (e) {
      SnackBar(content: Text('sorry there is problem now with  audio $e'));
    }
  }
}
