import 'package:flutter/material.dart';
import '../models/popular/popular_tmdb.dart';
import 'row_trending_home_view_under_backdrop_item.dart';

class RowTrendingHomeViewUnderBackdrop extends StatelessWidget {
  final List<popular> popularList;
  final Function(String) onImageTap;

  const RowTrendingHomeViewUnderBackdrop({
    super.key,
    required this.popularList,
    required this.onImageTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 8,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return RowTrendingHomeViewUnderBackdropItem(
            Popular: popularList[index],
            onImageTap: onImageTap,
          );
        },
      ),
    );
  }
}
