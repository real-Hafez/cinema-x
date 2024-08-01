import 'package:cinema_x/Movies/widgets/Text_Widget_For_About.dart';
import 'package:flutter/material.dart';

class Status_Movie_About extends StatelessWidget {
  const Status_Movie_About({
    super.key,
    required this.status,
  });

  final String status;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text_Widget_For_About(
          text: 'Status',
        ),
        SizedBox(height: MediaQuery.of(context).size.height * .001),
        Text(
          status,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w100,
              fontSize: MediaQuery.of(context).size.height * .02),
        ),
      ],
    );
  }
}
