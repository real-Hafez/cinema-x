import 'package:flutter/material.dart';

class sliver_App_Bar extends StatelessWidget {
  const sliver_App_Bar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: const Color(0xff090E17),
      pinned: true,
      expandedHeight: MediaQuery.of(context).size.height * 0.15,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.height * .03),
          child: Text(
            "Pick What You'd Like To Watch",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: MediaQuery.of(context).size.height * .03,
            ),
          ),
        ),
      ),
    );
  }
}
