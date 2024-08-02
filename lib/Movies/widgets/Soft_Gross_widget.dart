import 'package:cinema_x/Movies/widgets/Text_Widget_For_About.dart';
import 'package:flutter/material.dart';

class Soft_Gross_widget extends StatelessWidget {
  const Soft_Gross_widget({
    super.key,
    required this.softGross,
    required this.softGrossColor,
  });

  final num softGross;
  final MaterialColor softGrossColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text_Widget_For_About(
                text: 'Soft Gross',
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .0005),
              Text(
                '\$${softGross.toStringAsFixed(0)}',
                style: TextStyle(
                    color: softGrossColor,
                    fontWeight: FontWeight.w100,
                    fontSize: MediaQuery.of(context).size.height * .02),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
