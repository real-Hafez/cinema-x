import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: MediaQuery.of(context).size.width * .19,
          child: Image.asset(
            'assets/Images/logo_transpernent.png',
          ),
        ),
      ),
    );
  }
}
