import 'package:flutter/material.dart';
import '../models/popular/popular_tmdb.dart';
import 'row_trending_home_view_under_backdrop_item.dart';

class RowTrendingHomeViewUnderBackdrop extends StatelessWidget {
  final List<popular> popularList;
  final Function(String, String) onImageTap;

  const RowTrendingHomeViewUnderBackdrop({
    super.key,
    required this.popularList,
    required this.onImageTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 8,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return swipe_for_another_popular_under_backdrop_item(
            Popular: popularList[index],
            onImageTap: (imageUrl) {
              final nameOrTitle =
                  popularList[index].title ?? popularList[index].name!;
              onImageTap(imageUrl, nameOrTitle);
            },
          );
        },
      ),
    );
  }
}
