import 'package:auto_size_text/auto_size_text.dart';
import 'package:cinema_x/Movies/model/detilis_model/detilis.dart';
import 'package:cinema_x/Movies/widgets/Text_Widget_For_About.dart';
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text_Widget_For_About(
                      text: 'Audio track',
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .001),
                    Text(
                      spokenLanguages.join('  ,  '),
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w100,
                          fontSize: MediaQuery.of(context).size.height * .02),
                    ),
                  ],
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * .05),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text_Widget_For_About(
                      text: 'Country',
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .001),
                    AutoSizeText(
                      originCountries.join(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w100,
                        fontSize: MediaQuery.of(context).size.height * .02,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .02),
          // Row 2: Year and Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text_Widget_For_About(
                      text: 'Year',
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .001),
                    Text(
                      year,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w100,
                          fontSize: MediaQuery.of(context).size.height * .02),
                    ),
                  ],
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * .05),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text_Widget_For_About(
                      text: 'Status',
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .001),
                    Text(
                      status,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w100,
                          fontSize: MediaQuery.of(context).size.height * .02),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .02),
          // Row 3: Rating and Votes
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text_Widget_For_About(
                      text: 'Rating',
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .001),
                    Row(
                      children: [
                        RatingBarIndicator(
                          unratedColor: Colors.grey,
                          rating: voteAverage / 2, // Assuming 10-point scale
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: MediaQuery.of(context).size.height * .025,
                          direction: Axis.horizontal,
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * .02),
                        // Text(
                        //   '${voteAverage.toStringAsFixed(1)}/5',
                        //   style: TextStyle(
                        //       color: Colors.white,
                        //       fontWeight: FontWeight.w100,
                        //       fontSize:
                        //           MediaQuery.of(context).size.height * .02),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * .05),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text_Widget_For_About(
                      text: 'Votes',
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .001),
                    Text(
                      '$voteCount votes',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w100,
                          fontSize: MediaQuery.of(context).size.height * .02),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .02),
          // Row 4: Budget and Revenue
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text_Widget_For_About(
                      text: 'Budget',
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .001),
                    Text(
                      '\$${budget.toStringAsFixed(0)}',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w100,
                          fontSize: MediaQuery.of(context).size.height * .02),
                    ),
                  ],
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * .05),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text_Widget_For_About(
                      text: 'Revenue',
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .001),
                    Text(
                      '\$${revenue.toStringAsFixed(0)}',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w100,
                          fontSize: MediaQuery.of(context).size.height * .02),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * .02),
          // Row 5: Soft Gross
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text_Widget_For_About(
                      text: 'Soft Gross',
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * .0005),
                    Text(
                      '\$${softGross.toStringAsFixed(0)}',
                      style: TextStyle(
                          color: softGrossColor,
                          fontWeight: FontWeight.w100,
                          fontSize: MediaQuery.of(context).size.height * .02),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
