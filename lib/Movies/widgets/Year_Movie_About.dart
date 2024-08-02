import 'package:cinema_x/Movies/widgets/Text_Widget_For_About.dart';
import 'package:flutter/material.dart';

class Year_Movie_About extends StatelessWidget {
  const Year_Movie_About({
    super.key,
    required this.year,
  });

  final String year;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text_Widget_For_About(
          text: 'Year',
        ),
        SizedBox(height: MediaQuery.of(context).size.height * .001),
        Text(
          year,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w100,
              fontSize: MediaQuery.of(context).size.height * .02),
        ),
      ],
    );
  }
}
