import 'package:cinema_x/login_and_sign_up_pages/widgets/Email_widget.dart';
import 'package:cinema_x/login_and_sign_up_pages/widgets/First_Name_widget.dart';
import 'package:cinema_x/login_and_sign_up_pages/widgets/Last_Name_widget.dart';
import 'package:cinema_x/login_and_sign_up_pages/widgets/Password_widget.dart';
import 'package:cinema_x/login_and_sign_up_pages/widgets/confirm_Password_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class sign_up_screen extends StatelessWidget {
  const sign_up_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: const SingleChildScrollView(
              child: Column(
                children: [
                  First_Name_widget(),
                  Last_Name_widget(),
                  Email_widget(),
                  Password_widget(),
                  confirm_Password_widget(),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
