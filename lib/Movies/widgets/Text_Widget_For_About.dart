import 'package:flutter/material.dart';

class Text_Widget_For_About extends StatelessWidget {
  const Text_Widget_For_About({
    super.key,
    required this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: Colors.white,
          fontSize: MediaQuery.of(context).size.height * .025,
          fontWeight: FontWeight.bold),
    );
  }
}
