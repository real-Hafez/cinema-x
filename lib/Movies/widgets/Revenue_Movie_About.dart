import 'package:cinema_x/Movies/widgets/Text_Widget_For_About.dart';
import 'package:flutter/material.dart';

class Revenue_Movie_About extends StatelessWidget {
  const Revenue_Movie_About({
    super.key,
    required this.revenue,
  });

  final num revenue;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text_Widget_For_About(
            text: 'Revenue',
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .001),
          Text(
            '\$${revenue.toStringAsFixed(0)}',
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

