import 'package:cinema_x/Actor/Screen/Actor_Screen.dart';
import 'package:cinema_x/Movies/Screen/Movies_Screen.dart';
import 'package:cinema_x/TV/Screen/Series_Screen.dart';
import 'package:flutter/material.dart';

class WatchNowButton extends StatelessWidget {
  final int movieId;
  final int tvId;
  final int actorId;
  final bool isMovie;
  final bool isTv;
  final bool isActor;

  const WatchNowButton({
    super.key,
    required this.movieId,
    required this.tvId,
    required this.actorId,
    required this.isMovie,
    required this.isTv,
    required this.isActor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (isMovie) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MoviesScreen(movieId: movieId),
            ),
          );
        } else if (isTv) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TvSeriesScreen(tvId: tvId),
            ),
          );
        } else if (isActor) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ActorScreen(actorId: actorId),
            ),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.025,
          horizontal: MediaQuery.of(context).size.height * 0.025,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            MediaQuery.of(context).size.height * 0.1,
          ),
        ),
      ),
      child: Text(
        'Watch Now',
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.height * 0.025,
        ),
      ),
    );
  }
}
