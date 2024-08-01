import 'package:auto_size_text/auto_size_text.dart';
import 'package:cinema_x/Movies/model/detilis_model/detilis.dart';
import 'package:cinema_x/Movies/widgets/Audiotrack_Movie_About.dart';
import 'package:cinema_x/Movies/widgets/Budget_Movie_about.dart';
import 'package:cinema_x/Movies/widgets/Country_Movie_About.dart';
import 'package:cinema_x/Movies/widgets/Revenue_Movie_About.dart';
import 'package:cinema_x/Movies/widgets/Soft_Gross_widget.dart';
import 'package:cinema_x/Movies/widgets/Status_Movie_About.dart';
import 'package:cinema_x/Movies/widgets/Text_Widget_For_About.dart';
import 'package:cinema_x/Movies/widgets/Votes_And_Rating_Row.dart';
import 'package:cinema_x/Movies/widgets/Year_Movie_About.dart';
import 'package:cinema_x/SearchPage/model/Search_Result_Model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class About_Movie extends StatelessWidget {
  const About_Movie({
    super.key,
    required this.movie,
    required this.detilis,
  });

  final SearchResultModel movie;
  final Detilis detilis;

  @override
  Widget build(BuildContext context) {
    final spokenLanguages = detilis.spokenLanguages
            ?.map((language) => language.englishName)
            .toList() ??
        ['I don\'t know'];
    final originCountries =
        detilis.originCountry?.map((country) => country.toString()).toList() ??
            ['Unknown'];

    final budget = detilis.budget ?? 0;
    final revenue = detilis.revenue ?? 0;
    final softGross = revenue - budget;
    final softGrossColor = softGross > 0 ? Colors.green : Colors.red;

    final year = detilis.releaseDate?.split('-').first ?? 'Unknown';
    final status = detilis.status ?? 'Unknown';
    final voteAverage = movie.voteAverage ?? 0;
    final voteCount = movie.voteCount?.toString() ?? '0';

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * .05,
        vertical: MediaQuery.of(context).size.height * .01,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Audiotrack_Movie_About(spokenLanguages: spokenLanguages),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * .05),
              Expanded(
                child: Country_Movie_About(originCountries: originCountries),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .02),
          // Row 2: Year and Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Year_Movie_About(year: year),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * .05),
              Expanded(
                child: Status_Movie_About(status: status),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .02),
          // Row 3: Rating and Votes
          Votes_And_Rating_Row(voteAverage: voteAverage, voteCount: voteCount),
          SizedBox(height: MediaQuery.of(context).size.height * .02),
          // Row 4: Budget and Revenue
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Budget_Movie_about(budget: budget),
              SizedBox(width: MediaQuery.of(context).size.width * .05),
              Revenue_Movie_About(revenue: revenue),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .02),
          // Row 5: soft gross
          Soft_Gross_widget(
              softGross: softGross, softGrossColor: softGrossColor),
        ],
      ),
    );
  }
}
