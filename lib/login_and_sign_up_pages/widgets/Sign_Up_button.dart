import 'package:cinema_x/login_and_sign_up_pages/service/auth_Service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Sign_Up_button extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const Sign_Up_button({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

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
            colors: [Color(0xff4facfe), Color(0xff00f2fe)], // Gradient colors
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ElevatedButton(
          onPressed: () async {
            try {
              await AuthService().signup(
                email: emailController.text,
                password: passwordController.text,
                context: context,
              );
            } catch (e) {
              print(e.toString());
              Fluttertoast.showToast(
                msg: 'Login failed. Please try again.',
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
              borderRadius: BorderRadius.circular(25.0), // Rounded corners
            ),
          ),
          child: Text(
            'Sign Up',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * .04,
              color: Colors.white, // Text color
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
