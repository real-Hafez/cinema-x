import 'package:cinema_x/for_you_row/widgets/for_you_row_body.dart';
import 'package:flutter/material.dart';

class for_you_row extends StatelessWidget {
  const for_you_row({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        for_you_row_body(),
      ],
    );
  }
}
