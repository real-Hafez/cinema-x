import 'package:auto_size_text/auto_size_text.dart';
import 'package:cinema_x/Movies/widgets/Text_Widget_For_About.dart';
import 'package:flutter/material.dart';

class Country_Movie_About extends StatelessWidget {
  const Country_Movie_About({
    super.key,
    required this.originCountries,
  });

  final List<String> originCountries;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text_Widget_For_About(
          text: 'Country',
        ),
        SizedBox(height: MediaQuery.of(context).size.height * .001),
        AutoSizeText(
          originCountries.join(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w100,
            fontSize: MediaQuery.of(context).size.height * .02,
          ),
        ),
      ],
    );
  }
}
