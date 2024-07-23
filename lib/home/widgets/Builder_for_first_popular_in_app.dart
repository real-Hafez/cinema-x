import 'package:cinema_x/home/models/popular/popular_tmdb.dart';
import 'package:cinema_x/home/service/popular_service.dart';
import 'package:cinema_x/home/widgets/first_show_case_popular.dart';
import 'package:flutter/material.dart';

class Builder_for_first_popular_in_app extends StatelessWidget {
  const Builder_for_first_popular_in_app({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<popular>>(
      future: popularService.fetchPopular(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No data available'));
        } else {
          final popularList = snapshot.data!;
          return FirstShowCasePopular(popularList: popularList);
        }
      },
    );
  }
}
