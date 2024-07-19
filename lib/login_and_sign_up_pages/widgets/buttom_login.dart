import 'dart:ui';

import 'package:cinema_x/Home_page/screen/home_screen.dart';
import 'package:cinema_x/login_and_sign_up_pages/service/auth_Service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class buttom_login extends StatelessWidget {
  const buttom_login({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * .06,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          gradient: const LinearGradient(
            colors: [Color(0xff4facfe), Color(0xff00f2fe)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ElevatedButton(
          onPressed: () async {
            try {
              // Call the signin method from AuthService
              await AuthService().signin(
                email: emailController.text,
                password: passwordController.text,
                context: context,
              );

              // Save the email to SharedPreferences
              final SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
              sharedPreferences.setString('email', emailController.text);

              // Navigate to the Home_screen
              // This will be handled by the signin method itself
            } catch (e) {
              // Handle any additional errors here if necessary
              print(e.toString());
              Fluttertoast.showToast(
                msg: 'An error occurred during login. Please try again.',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.SNACKBAR,
                backgroundColor: Colors.black54,
                textColor: Colors.white,
                fontSize: 14.0,
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
          child: Text(
            'Log in',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * .04,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
