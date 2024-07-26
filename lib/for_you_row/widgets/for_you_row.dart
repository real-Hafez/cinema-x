import 'package:cinema_x/for_you_row/widgets/for_you_item.dart';
import 'package:cinema_x/for_you_row/widgets/for_you_item_Series.dart';
import 'package:cinema_x/for_you_row/widgets/for_you_row_body.dart';
import 'package:flutter/material.dart';

class for_you_row extends StatelessWidget {
  const for_you_row({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const for_you_row_body(
            text_for_row_or_movie: 'Movies For You',
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .35,
            child: const for_you_item(
              showAll: true,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .02,
          ),
          const for_you_row_body(
            text_for_row_or_movie: 'series For You ',
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .02,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .35,
            child: const for_you_item_series(
              showAll: true,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * .02,
          ),
        ],
      ),
    );
  }
}
