import 'package:cinema_x/Home_page/screen/home_screen.dart';
import 'package:cinema_x/login_and_sign_up_pages/bloc/login/cubit/login_cubit.dart';
import 'package:cinema_x/login_and_sign_up_pages/screens/sign_up_screen.dart';
import 'package:cinema_x/login_and_sign_up_pages/service/auth_Service.dart';
import 'package:cinema_x/login_and_sign_up_pages/widgets/Password_login.dart';
import 'package:cinema_x/login_and_sign_up_pages/widgets/buttom_login.dart';
import 'package:cinema_x/login_and_sign_up_pages/widgets/email_login.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as get_package;
import 'package:fluttertoast/fluttertoast.dart';

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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            // Scrollable section for the input fields and buttons
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                email_login(
                  controller: emailController,
                ),
                Password_Login(
                  controller: passwordController,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * .04),
                BlocProvider(
                  create: (context) => LoginCubit(AuthService()),
                  child: BlocConsumer<LoginCubit, LoginState>(
                    listener: (context, state) {
                      if (state is LoginSuccess) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Home_screen(),
                          ),
                        );
                      } else if (state is LoginFailure) {
                        Fluttertoast.showToast(
                          msg: state.error,
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.SNACKBAR,
                          backgroundColor: Colors.black54,
                          textColor: Colors.white,
                          fontSize: 18.0,
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is LoginLoading) {
                        return const CircularProgressIndicator();
                      }
                      return buttom_login(
                        emailController: emailController,
                        passwordController: passwordController,
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .02,
                ),
                const Text(
                  'Forget your password?',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .03,
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
                              transition: get_package.Transition.leftToRight,
                            );
                          },
                        text: 'Sign up',
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
