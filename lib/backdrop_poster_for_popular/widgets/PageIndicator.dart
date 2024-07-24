import 'package:flutter/material.dart';

class PageIndicator extends StatefulWidget {
  final int itemCount;
  final int currentPage;

  const PageIndicator({
    required this.itemCount,
    required this.currentPage,
    super.key,
  });

  @override
  _PageIndicatorState createState() => _PageIndicatorState();
}

class _PageIndicatorState extends State<PageIndicator> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.itemCount, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          width: widget.currentPage == index ? 30 : 10,
          height: 8,
          decoration: BoxDecoration(
            color: widget.currentPage == index ? Colors.blue : Colors.grey,
            borderRadius: BorderRadius.circular(4.0),
          ),
        );
      }),
    );
  }
}
