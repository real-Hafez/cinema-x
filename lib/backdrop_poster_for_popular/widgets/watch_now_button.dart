import 'package:flutter/material.dart';

class watch_now_button extends StatelessWidget {
  const watch_now_button({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.025,
              horizontal: MediaQuery.of(context).size.height * 0.025),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(MediaQuery.of(context).size.height * 0.1),
          ),
        ),
        child: Text(
          'Watch Now',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.025,
          ),
        ));
  }
}
