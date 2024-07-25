import 'package:cinema_x/for_you_row/service/for_you_service_movies.dart';
import 'package:cinema_x/for_you_row/widgets/see_all_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cinema_x/for_you_row/widgets/for_you_item.dart';

class ForYouRowBody extends StatelessWidget {
  const ForYouRowBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .05,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * .06),
              child: Text(
                'For You',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * .07,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * .06),
              child: Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width * .09),
                  splashColor: Colors.blueAccent.withOpacity(0.2),
                  highlightColor: Colors.blue.withOpacity(0.1),
                  onTap: () async {
                    final movies =
                        await for_you_service_movies().fetchMovies(1);
                    Get.to(() => const SeeAllButton(
                          movies: [],
                          // showAll: true,
                        ));
                  },
                  child: Text(
                    'See all',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * .07,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
