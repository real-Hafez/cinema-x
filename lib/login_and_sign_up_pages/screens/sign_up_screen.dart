import 'package:cinema_x/Home_page/screen/home_screen.dart';
import 'package:cinema_x/login_and_sign_up_pages/bloc/signup/cubit/signup_cubit.dart';
import 'package:cinema_x/login_and_sign_up_pages/screens/login_screen.dart';
import 'package:cinema_x/login_and_sign_up_pages/service/auth_Service.dart';
import 'package:cinema_x/login_and_sign_up_pages/widgets/Email_widget.dart';
import 'package:cinema_x/login_and_sign_up_pages/widgets/Password_widget.dart';
import 'package:cinema_x/login_and_sign_up_pages/widgets/Sign_Up_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart' as get_package;
import 'package:get/get_navigation/src/routes/transitions_type.dart'
    as get_transitions;

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(AuthService()),
      child: Scaffold(
        backgroundColor: const Color(0xff090E17),
        body: BlocConsumer<SignupCubit, SignupCubitState>(
          listener: (context, state) {
            if (state is SignupCubitfailure) {
              Fluttertoast.showToast(
                msg: state.error,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.SNACKBAR,
                backgroundColor: Colors.black54,
                textColor: Colors.white,
                fontSize: 18.0,
              );
            } else if (state is SignupCubitsucsess) {
              Future.delayed(const Duration(seconds: 1), () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Home_screen(),
                  ),
                );
              });
            }
          },
          builder: (context, state) {
            if (state is SignupCubitloading) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              );
            }
            return SingleChildScrollView(
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
                      Email_widget(
                        controller: emailController,
                      ),
                      Password_sign_up(
                        controller: passwordController,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .01,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Sign_Up_button(
                          emailController: emailController,
                          passwordController: passwordController,
                        ),
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
                                  get_package.Get.to(
                                    () => LoginScreen(),
                                    transition:
                                        get_transitions.Transition.rightToLeft,
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
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
