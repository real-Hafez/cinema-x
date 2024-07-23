import 'package:flutter/material.dart';

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
              margin: const EdgeInsets.symmetric(horizontal: 5),
              width: _currentPage == index ? 30 : 10,
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
