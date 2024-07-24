import 'dart:async';

import 'package:cinema_x/backdrop_poster_for_popular/ApiConfig.dart';
import 'package:cinema_x/backdrop_poster_for_popular/widgets/PageIndicator.dart';
import 'package:cinema_x/backdrop_poster_for_popular/widgets/Row_tending_home_view.dart';
import 'package:cinema_x/backdrop_poster_for_popular/widgets/tending_backdrop.dart';
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
  String? selectedNameOrTitle;
  int currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (widget.popularList.isNotEmpty) {
      selectedImageUrl =
          '${ApiConfig.imageBaseUrl}${widget.popularList[0].backdropPath}';
      selectedNameOrTitle =
          widget.popularList[0].title ?? widget.popularList[0].name!;
    }
    _startAutoChange();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startAutoChange() {
    _timer = Timer.periodic(const Duration(seconds: 7), (timer) {
      setState(() {
        currentPage = (currentPage + 1) % 8;
        selectedImageUrl =
            '${ApiConfig.imageBaseUrl}${widget.popularList[currentPage].backdropPath}';
        selectedNameOrTitle = widget.popularList[currentPage].title ??
            widget.popularList[currentPage].name!;
      });
    });
  }

  void _handleImageTap(String imageUrl, String nameOrTitle, int index) {
    setState(() {
      selectedImageUrl = imageUrl;
      selectedNameOrTitle = nameOrTitle;
      currentPage = index;
    });
    _timer?.cancel();
    _startAutoChange();
  }

  @override
  Widget build(BuildContext context) {
    final firstMovie =
        widget.popularList.isNotEmpty ? widget.popularList[0] : null;

    return Column(
      children: [
        if (firstMovie != null)
          TrendingBackdrop(
            nameOrTitle:
                selectedNameOrTitle ?? firstMovie.title ?? firstMovie.name!,
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
            onImageTap: (imageUrl, nameOrTitle) {
              final index = widget.popularList.indexWhere((popular) =>
                  '${ApiConfig.imageBaseUrl}${popular.backdropPath}' ==
                  imageUrl);
              if (index != -1) {
                _handleImageTap(imageUrl, nameOrTitle, index);
              }
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
    );
  }
}
