import 'package:cinema_x/for_you_row/widgets/see_all_button.dart';
import 'package:flutter/material.dart';
import 'package:cinema_x/for_you_row/service/for_you_service_movies.dart';
import 'package:cinema_x/for_you_row/model/for_you_model_movies.dart';

class for_you_row_body extends StatefulWidget {
  const for_you_row_body({super.key});

  @override
  _for_you_row_bodyState createState() => _for_you_row_bodyState();
}

class _for_you_row_bodyState extends State<for_you_row_body> {
  List<for_you_model_movies> movies = [];

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  void fetchMovies() async {
    final service = for_you_service_movies();
    final fetchedMovies = await service.fetchMovies(1);
    setState(() {
      movies = fetchedMovies;
    });
  }

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
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SeeAllButton(movies: movies),
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
