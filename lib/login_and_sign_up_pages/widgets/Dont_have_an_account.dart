import 'dart:ui';
import 'package:get/get.dart' as get_package;
import 'package:get/get_navigation/src/routes/transitions_type.dart'
    as get_transitions;
import 'package:cinema_x/login_and_sign_up_pages/screens/sign_up_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Dont_have_an_account extends StatelessWidget {
  const Dont_have_an_account({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "Don't have an account? ",
        style: TextStyle(
          color: Colors.white,
          fontSize: MediaQuery.of(context).size.height * .02,
          fontWeight: FontWeight.w300,
        ),
        children: <TextSpan>[
          TextSpan(
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                get_package.Get.to(
                  () => SignUpScreen(),
                  transition: get_transitions.Transition.rightToLeft,
                );
              },
            text: 'Sign Up',
            style: const TextStyle(
              color: Color(0xff4facfe),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
