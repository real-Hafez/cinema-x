import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * -0.35,
      bottom: MediaQuery.of(context).size.width * -0.01,
      child: Container(
        width: 100,
        child: Image.asset(
          'assets/Images/logo_transpernent.png',
        ),
      ),
    );
  }
}