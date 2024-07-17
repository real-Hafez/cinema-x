import 'package:flutter/material.dart';

class slogan_text extends StatelessWidget {
  const slogan_text({
    super.key,
    required this.SloganAnimation,
  });

  final Animation<Offset> SloganAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: SloganAnimation,
        builder: (context, _) {
          return SlideTransition(
            position: SloganAnimation,
            child: const Text(
              'Cinema X: Discover. Stream. Enjoy.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        });
  }
}
