import 'package:cinema_x/Movies/widgets/Text_Widget_For_About.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Votes_And_Rating_Row extends StatelessWidget {
  const Votes_And_Rating_Row({
    super.key,
    required this.voteAverage,
    required this.voteCount,
  });

  final double voteAverage;
  final String voteCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text_Widget_For_About(
                text: 'Rating',
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .001),
              Row(
                children: [
                  RatingBarIndicator(
                    unratedColor: Colors.grey,
                    rating: voteAverage / 2, // Assuming 10-point scale
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: MediaQuery.of(context).size.height * .025,
                    direction: Axis.horizontal,
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * .02),
                ],
              ),
            ],
          ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * .05),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text_Widget_For_About(
                text: 'Votes',
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .001),
              Text(
                '$voteCount votes',
                style: TextStyle(
                    color: Colors.white,
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
