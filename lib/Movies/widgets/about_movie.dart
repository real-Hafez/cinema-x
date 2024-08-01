import 'package:cinema_x/SearchPage/model/Search_Result_Model.dart';
import 'package:flutter/material.dart';

class About_Movie extends StatelessWidget {
  const About_Movie({
    super.key,
    required this.movie,
  });

  final SearchResultModel movie;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * .05,
              top: MediaQuery.of(context).size.height * .01),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Audio track',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.height * .02),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * .0001),
              Container(
                height: 100,
                width: 100,
                child: Text(
                  '${movie.originalLanguage}',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.height * .018),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
