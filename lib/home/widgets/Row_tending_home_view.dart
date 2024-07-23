import 'package:cinema_x/home/models/popular/popular_tmdb.dart';
import 'package:cinema_x/home/widgets/row_trending_home_view_under_backdrop_item.dart';
import 'package:flutter/material.dart';

class Row_tending_home_view_under_backdrop extends StatelessWidget {
  const Row_tending_home_view_under_backdrop({
    super.key,
    required this.popularList,
  });
  final List<popular> popularList;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.5,
          crossAxisCount: 1,
        ),
        itemCount: 8,
        itemBuilder: (BuildContext context, int index) {
          final popular = popularList[index];

          return row_trending_home_view_under_backdrop_item(
            Popular: popular,
          );
        },
      ),
    );
  }
}
