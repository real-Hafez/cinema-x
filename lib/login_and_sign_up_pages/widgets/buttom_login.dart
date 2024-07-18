import 'package:cinema_x/login_and_sign_up_pages/service/auth_Service.dart';
import 'package:flutter/material.dart';

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
            colors: [Color(0xff4facfe), Color(0xff00f2fe)], // Gradient colors
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ElevatedButton(
          onPressed: () {
            AuthService().signin(
              email: emailController.text,
              password: passwordController.text,
              context: context,
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor:
                Colors.transparent, // Set the button background to transparent
            shadowColor: Colors.transparent, // Remove shadow
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0), // Rounded corners
            ),
          ),
          child: Text(
            'Log in',
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
