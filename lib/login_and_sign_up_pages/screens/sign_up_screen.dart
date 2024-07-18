import 'package:cinema_x/HomeView.dart';
import 'package:cinema_x/login_and_sign_up_pages/screens/login_screen.dart';
import 'package:cinema_x/login_and_sign_up_pages/widgets/Email_widget.dart';
import 'package:cinema_x/login_and_sign_up_pages/widgets/First_Name_widget.dart';
import 'package:cinema_x/login_and_sign_up_pages/widgets/Last_Name_widget.dart';
import 'package:cinema_x/login_and_sign_up_pages/widgets/Password_widget.dart';
import 'package:cinema_x/login_and_sign_up_pages/widgets/Sign_Up_button.dart';
import 'package:cinema_x/login_and_sign_up_pages/widgets/confirm_Password_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff090E17),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        reverse: true,
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          children: [
            Center(
              child: SafeArea(
                child: Image.asset(
                  'assets/Images/android-chrome-192x192.png',
                  height: MediaQuery.of(context).size.height * .2,
                  width: double.infinity,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .01,
            ),
            Text(
              'Sign Up',
              style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.height * .05,
              ),
            ),
            Column(
              children: [
                const First_Name_widget(),
                const Last_Name_widget(),
                const Email_widget(),
                const Password_widget(),
                const confirm_Password_widget(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .01,
                ),
                const Padding(
                  padding: EdgeInsets.all(5),
                  child: Sign_Up_button(),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Already have an account? ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.height * .02,
                      fontWeight: FontWeight.w300,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.to(
                              () => const LoginScreen(),
                              transition: Transition.rightToLeft,
                            );
                          },
                        text: 'Log In',
                        style: const TextStyle(
                          color: Color(0xff4facfe),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                // SizedBox(
                //   height: MediaQuery.of(context).size.height * .02,
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
