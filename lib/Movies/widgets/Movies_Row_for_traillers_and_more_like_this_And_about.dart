import 'package:cinema_x/Movies/model/detilis_model/detilis.dart';
import 'package:cinema_x/Movies/widgets/More_Like_this.dart';
import 'package:cinema_x/Movies/widgets/Trailers.dart';
import 'package:cinema_x/Movies/widgets/about_movie.dart';
import 'package:cinema_x/SearchPage/model/Search_Result_Model.dart';
import 'package:flutter/material.dart';
import 'package:cinema_x/Movies/model/Videos_model.dart';

class Movies_Row_for_traillers_and_more_like_this_And_about
    extends StatelessWidget {
  const Movies_Row_for_traillers_and_more_like_this_And_about({
    super.key,
    required this.movie,
    required this.detilis,
    required this.trailers,
    required this.onTrailerSelected,
  });

  final SearchResultModel movie;
  final Detilis detilis;
  final List<Video_Movies_model> trailers;
  final void Function(Video_Movies_model) onTrailerSelected;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final height = screenHeight * 0.5;

    return DefaultTabController(
      length: 3,
      child: SizedBox(
        height: height,
        child: Column(
          children: [
            const TabBar(
              padding: EdgeInsets.zero,
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(width: 4, color: Colors.blue),
              ),
              tabs: [
                Tab(text: 'Trailers'),
                Tab(text: 'More Like This'),
                Tab(text: 'About'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Trailers(
                    trailers: trailers,
                    onTrailerSelected: onTrailerSelected,
                  ),
                  MoreLikeThis(detilis: detilis),
                  About_Movie(
                    movie: movie,
                    detilis: detilis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
