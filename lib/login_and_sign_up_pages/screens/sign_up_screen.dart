import 'package:cinema_x/login_and_sign_up_pages/widgets/Email_widget.dart';
import 'package:cinema_x/login_and_sign_up_pages/widgets/First_Name_widget.dart';
import 'package:cinema_x/login_and_sign_up_pages/widgets/Last_Name_widget.dart';
import 'package:cinema_x/login_and_sign_up_pages/widgets/Password_widget.dart';
import 'package:cinema_x/login_and_sign_up_pages/widgets/confirm_Password_widget.dart';
import 'package:flutter/material.dart';

class sign_up_screen extends StatelessWidget {
  const sign_up_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
              const SizedBox(
                height: 10,
              ),
              TextButton(
                  style: const ButtonStyle(),
                  onPressed: () {},
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
