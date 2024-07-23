import 'package:cinema_x/home/ApiConfig.dart';
import 'package:cinema_x/home/widgets/PageIndicator.dart';
import 'package:cinema_x/home/widgets/Row_tending_home_view.dart';
import 'package:cinema_x/home/widgets/tending_backdrop.dart';
import 'package:flutter/material.dart';
import '../models/popular/popular_tmdb.dart';

class FirstShowCasePopular extends StatefulWidget {
  final List<popular> popularList;

  const FirstShowCasePopular({
    super.key,
    required this.popularList,
  });

  @override
  _FirstShowCasePopularState createState() => _FirstShowCasePopularState();
}

class _FirstShowCasePopularState extends State<FirstShowCasePopular> {
  String? selectedImageUrl;
  int currentPage = 0;

  void _handleImageTap(String imageUrl, int index) {
    setState(() {
      selectedImageUrl = imageUrl;
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final firstMovie =
        widget.popularList.isNotEmpty ? widget.popularList[0] : null;

    return SafeArea(
      child: Column(
        children: [
          if (firstMovie != null)
            TrendingBackdrop(
              imageUrl: selectedImageUrl ??
                  '${ApiConfig.imageBaseUrl}${firstMovie.backdropPath}',
            ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.08,
            width: double.infinity,
            child: RowTrendingHomeViewUnderBackdrop(
              popularList: widget.popularList,
              onImageTap: (imageUrl) {
                setState(() {
                  selectedImageUrl = imageUrl;
                  currentPage = widget.popularList.indexWhere((popular) =>
                      '${ApiConfig.imageBaseUrl}${popular.backdropPath}' ==
                      imageUrl);
                });
              },
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
          ),
          PageIndicator(
            itemCount: 8,
            currentPage: currentPage,
          ),
        ],
      ),
    );
  }
}
