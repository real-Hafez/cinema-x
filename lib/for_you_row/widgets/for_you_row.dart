import 'package:cinema_x/for_you_row/widgets/for_you_item.dart';
import 'package:cinema_x/for_you_row/widgets/for_you_row_body.dart';
import 'package:flutter/material.dart';

class for_you_row extends StatelessWidget {
  const for_you_row({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .35,
      width: double.infinity,
      child: Column(
        children: [
          const for_you_row_body(),
          SizedBox(
            height: MediaQuery.of(context).size.height * .02,
          ),
          const Expanded(child: for_you_item()),
        ],
      ),
    );
  }
}
