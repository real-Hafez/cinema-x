import 'package:cinema_x/Popular_peoble_movies_series/widgets/trending_coulm.dart';
import 'package:cinema_x/backdrop_poster_for_popular_and_For_you_movies_and_series/widgets/Builder_for_first_popular_in_app.dart';
import 'package:cinema_x/for_you_row/widgets/for_you_row.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final ScrollController scrollController;

  const HomeScreen({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollInfo) {
        return true;
      },
      child: SingleChildScrollView(
        controller: scrollController,
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            backdrop_poster_for_popular(),
            SizedBox(height: 20),
            for_you_row(),
            TrendingCoulm(),
          ],
        ),
      ),
    );
  }
}
