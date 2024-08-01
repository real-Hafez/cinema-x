import 'package:cinema_x/Movies/widgets/Text_Widget_For_About.dart';
import 'package:flutter/material.dart';

class Budget_Movie_about extends StatelessWidget {
  const Budget_Movie_about({
    super.key,
    required this.budget,
  });

  final num budget;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text_Widget_For_About(
            text: 'Budget',
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .001),
          Text(
            '\$${budget.toStringAsFixed(0)}',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w100,
                fontSize: MediaQuery.of(context).size.height * .02),
          ),
        ],
      ),
    );
  }
}
