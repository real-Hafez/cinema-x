import 'package:cinema_x/login_and_sign_up_pages/screens/model_bottom_sheet_forget_password.dart';
import 'package:cinema_x/login_and_sign_up_pages/screens/sign_up_screen.dart';
import 'package:cinema_x/login_and_sign_up_pages/widgets/Password_login.dart';
import 'package:cinema_x/login_and_sign_up_pages/widgets/buttom_login.dart';
import 'package:cinema_x/login_and_sign_up_pages/widgets/email_login.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as get_package;
import 'package:get/get_navigation/src/routes/transitions_type.dart'
    as get_transitions;

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
              'Log In',
              style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.height * .05,
              ),
            ),
            Column(
              children: [
                email_login(
                  controller: emailController,
                ),
                Password_Login(
                  controller: passwordController,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .01,
                ),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: buttom_login(
                    emailController: emailController,
                    passwordController: passwordController,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return ModelBottomSheetForgetPassword();
                      },
                    );
                  },
                  child: Text(
                    'forgot password ?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.aspectRatio * 40,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                RichText(
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
                              transition:
                                  get_transitions.Transition.rightToLeft,
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
