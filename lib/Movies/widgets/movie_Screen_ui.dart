import 'package:auto_size_text/auto_size_text.dart';
import 'package:cinema_x/Movies/model/Videos_model.dart';
import 'package:cinema_x/Movies/model/detilis_model/detilis.dart';
import 'package:cinema_x/Movies/widgets/Movies_Row_for_traillers_and_more_like_this_And_about.dart';
import 'package:cinema_x/Movies/widgets/watch_Now_And_Add_to_wishlist_button.dart';
import 'package:cinema_x/Movies/widgets/youtubeplayer.dart';
import 'package:cinema_x/SearchPage/model/Search_Result_Model.dart';
import 'package:flutter/material.dart';

class movie_Screen_ui extends StatefulWidget {
  const movie_Screen_ui({
    super.key,
    required this.screenWidth,
    required this.videoHeight,
    required this.trailers,
    required this.movie,
    required this.detilis,
  });

  final double screenWidth;
  final double videoHeight;
  final List<Video_Movies_model> trailers;
  final SearchResultModel movie;
  final Detilis detilis;

  @override
  _movie_Screen_uiState createState() => _movie_Screen_uiState();
}

class _movie_Screen_uiState extends State<movie_Screen_ui> {
  Video_Movies_model? selectedTrailer;

  @override
  void initState() {
    super.initState();
    if (widget.trailers.isNotEmpty) {
      selectedTrailer = widget.trailers.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .04),
          child: Container(
            width: widget.screenWidth,
            height: widget.videoHeight,
            child: MyYoutubePlayer(
              videoUrl:
                  'https://www.youtube.com/watch?v=${selectedTrailer?.key ?? ''}',
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * .03),
        watch_Now_And_Add_to_wishlist_button(
          id: widget.detilis.id!,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * .03),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .04),
          child: AutoSizeText(
            '${widget.movie.overview}',
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
          detilis: widget.detilis,
          movie: widget.movie,
          trailers: widget.trailers,
          onTrailerSelected: (trailer) {
            setState(() {
              selectedTrailer = trailer;
            });
          },
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .01,
        ),
      ],
    );
  }
}
