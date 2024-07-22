import 'dart:ui';

import 'package:cinema_x/Pick_card/screen/pick_faviourite_genre.dart';
import 'package:cinema_x/login_and_sign_up_pages/service/auth_Service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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

              final SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
              sharedPreferences.setString('email', emailController.text);
              sharedPreferences.setString('password', passwordController.text);

              await authenticateUser(context);
            } catch (e) {
              print(e.toString());
              // Fluttertoast.showToast(
              //   msg: 'An error occurred during login. Please try again.',
              //   toastLength: Toast.LENGTH_LONG,
              //   gravity: ToastGravity.SNACKBAR,
              //   backgroundColor: Colors.black54,
              //   textColor: Colors.white,
              //   fontSize: 14.0,
              // );
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

  Future<void> authenticateUser(BuildContext context) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    String? email = sharedPreferences.getString('email');
    String? password = sharedPreferences.getString('password');

    if (email != null && password != null) {
      await AuthService().signin(
        email: email,
        password: password,
        context: context,
      );
    } else {
      Fluttertoast.showToast(
        msg: 'No email or password found in SharedPreferences.',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    }
  }
}
