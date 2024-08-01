import 'package:cinema_x/Movies/widgets/Text_Widget_For_About.dart';
import 'package:flutter/material.dart';

class Audiotrack_Movie_About extends StatelessWidget {
  const Audiotrack_Movie_About({
    super.key,
    required this.spokenLanguages,
  });

  final List<String?> spokenLanguages;

  @override
  Widget build(BuildContext context) {
    final displayedLanguages = spokenLanguages.take(2).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text_Widget_For_About(
          text: 'Audio track',
        ),
        SizedBox(height: MediaQuery.of(context).size.height * .001),
        Text(
          displayedLanguages.join('  ,  '),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w100,
            fontSize: MediaQuery.of(context).size.height * .02,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
