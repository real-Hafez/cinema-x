import 'package:cinema_x/home/service/popular_service.dart';
import 'package:flutter/material.dart';
import 'package:cinema_x/home/widgets/first_show_case_popular.dart';
import 'package:cinema_x/home/models/popular/popular_tmdb.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff090E17),
      body: FutureBuilder<List<popular>>(
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
            return first_show_case_popular(popularList: popularList);
          }
        },
      ),
    );
  }
}
