import 'package:cinema_x/Actor/Screen/Actor_Screen.dart';
import 'package:cinema_x/Movies/Screen/Movies_Screen.dart';
import 'package:cinema_x/TV/Screen/Series_Screen.dart';
import 'package:flutter/material.dart';
import 'package:cinema_x/Popular_peoble_movies_series/models/Person_Model.dart';

class WatchNowButton extends StatelessWidget {
  final Person_Model? personModel; // Nullable parameter
  final int movieId;
  final int tvId;
  final int actorId;
  final bool isMovie;
  final bool isTv;
  final bool isActor;

  const WatchNowButton({
    super.key,
    this.personModel, // Nullable parameter
    required this.movieId,
    required this.tvId,
    required this.actorId,
    required this.isMovie,
    required this.isTv,
    required this.isActor,
  });

  @override
  Widget build(BuildContext context) {
    if (isActor && personModel == null) {
      return const SizedBox();
    }

    return ElevatedButton(
      onPressed: () {
        if (isMovie) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MoviesScreen(movieId: movieId)),
          );
        } else if (isTv) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TvSeriesScreen(tvId: tvId)),
          );
        } else if (isActor) {
          if (personModel != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ActorScreen(personId: movieId)),
            );
          }
        }
      },
      child: Text(
        isMovie
            ? 'Watch Movie'
            : isTv
                ? 'Watch TV Show'
                : isActor
                    ? 'More Info'
                    : 'Info',
      ),
    );
  }
}
