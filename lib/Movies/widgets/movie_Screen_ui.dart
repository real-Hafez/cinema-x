import 'package:auto_size_text/auto_size_text.dart';
import 'package:cinema_x/Movies/model/Videos_model.dart';
import 'package:cinema_x/Movies/model/detilis_model/detilis.dart';
import 'package:cinema_x/Movies/widgets/Movies_Row_for_traillers_and_more_like_this_And_about.dart';
import 'package:cinema_x/Movies/widgets/watch_Now_And_Add_to_wishlist_button.dart';
import 'package:cinema_x/Movies/widgets/youtubeplayer.dart';
import 'package:cinema_x/SearchPage/model/Search_Result_Model.dart';
import 'package:flutter/material.dart';

class movie_Screen_ui extends StatelessWidget {
  const movie_Screen_ui({
    super.key,
    required this.screenWidth,
    required this.videoHeight,
    required this.selectedTrailer,
    required this.trailers,
    required this.movie,
    required this.detilis,
  });
  final double screenWidth;
  final double videoHeight;
  final Video_Movies_model? selectedTrailer;
  final List<Video_Movies_model> trailers;
  final SearchResultModel movie;
  final Detilis detilis;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .04),
          child: Container(
            width: screenWidth,
            height: videoHeight,
            child: MyYoutubePlayer(
              videoUrl:
                  'https://www.youtube.com/watch?v=${selectedTrailer?.key ?? ''}',
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * .03),
        const watch_Now_And_Add_to_wishlist_button(),
        SizedBox(height: MediaQuery.of(context).size.height * .03),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .04),
          child: AutoSizeText(
            '${movie.overview}',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * .04,
              color: Colors.white,
            ),
            maxFontSize: 25,
            minFontSize: 14,
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * .03),
        Movies_Row_for_traillers_and_more_like_this_And_about(
          detilis: detilis,
          movie: movie,
        ),
      ],
    );
  }
}
