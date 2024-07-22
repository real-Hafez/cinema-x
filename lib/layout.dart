import 'package:cinema_x/login_and_sign_up_pages/layout/mobile_layout.dart';
import 'package:cinema_x/login_and_sign_up_pages/layout/tabletlayout.dart';
import 'package:flutter/material.dart';

class layout extends StatelessWidget {
  const layout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: const Color(0xff090E17),
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 600) {
              return mobile_layout(context);
            } else if (constraints.maxWidth < 1024) {
              return tabletlayout(context);
            }
            return const SizedBox();
          },
        ));
  }
}
