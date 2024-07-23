import 'package:flutter/material.dart';
import '../models/popular/popular_tmdb.dart';
import 'Row_tending_home_view.dart';
import 'tending_backdrop.dart';

class first_show_case_popular extends StatelessWidget {
  final List<popular> popularList;

  const first_show_case_popular({
    super.key,
    required this.popularList,
  });

  @override
  Widget build(BuildContext context) {
    final firstMovie = popularList.isNotEmpty ? popularList[0] : null;

    return SafeArea(
      child: Column(
        children: [
          if (firstMovie != null) trending_backdrop(Popular: firstMovie),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
          ),
          Row_tending_home_view_under_backdrop(
            popularList: popularList,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
          ),
          const PageIndicator(8),
        ],
      ),
    );
  }
}

class PageIndicator extends StatefulWidget {
  final int itemCount;

  const PageIndicator(this.itemCount, {super.key});

  @override
  _PageIndicatorState createState() => _PageIndicatorState();
}

class _PageIndicatorState extends State<PageIndicator> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.itemCount, (index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              width: _currentPage == index ? 50 : 10,
              height: 8,
              decoration: BoxDecoration(
                color: _currentPage == index ? Colors.blue : Colors.grey,
                borderRadius: BorderRadius.circular(4.0),
              ),
            );
          }),
        ),
      ],
    );
  }
}
