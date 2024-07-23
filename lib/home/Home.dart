import 'package:cinema_x/home/service/popular_service.dart';
import 'package:cinema_x/home/widgets/Builder_for_first_popular_in_app.dart';
import 'package:flutter/material.dart';
import 'package:cinema_x/home/widgets/first_show_case_popular.dart';
import 'package:cinema_x/home/models/popular/popular_tmdb.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xff090E17),
      body: Column(
        children: [
          Builder_for_first_popular_in_app(),
        ],
      ),
    );
  }
}
