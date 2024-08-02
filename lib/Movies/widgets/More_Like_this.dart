import 'package:cinema_x/ApiConfig.dart';
import 'package:cinema_x/Movies/Screen/Movies_Screen.dart';
import 'package:cinema_x/Movies/model/detilis_model/detilis.dart';
import 'package:cinema_x/Movies/model/recommended_movies/recommended_Movies_model.dart';
import 'package:cinema_x/Movies/service/recommended_movies_%D9%8DService/recommended_Movies_Service.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MoreLikeThis extends StatelessWidget {
  const MoreLikeThis({super.key, required this.detilis});

  final Detilis detilis;

  Future<List<Recommendations_Movie_Model>> fetchRecommendedMovies() {
    return recommended_Movies_Service().fetchMovies(detilis.id!);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Recommendations_Movie_Model>>(
      future: fetchRecommendedMovies(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Errorrr: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No recommendations available'));
        } else {
          final recommendedMovies = snapshot.data!.take(6).toList();

          return Wrap(
            spacing: MediaQuery.of(context).size.width * .02,
            runSpacing: MediaQuery.of(context).size.width * .02,
            children: recommendedMovies.map((movie) {
              return SizedBox(
                width: MediaQuery.of(context).size.width / 3 - 8,
                height: MediaQuery.of(context).size.width / 2,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      transitions(movie),
                    );
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 3 - 8,
                    height: MediaQuery.of(context).size.width / 2,
                    child: CachedNetworkImage(
                      imageUrl: '${ApiConfig.imageBaseUrl}${movie.posterPath}',
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                        child: CircularProgressIndicator(
                          value: downloadProgress.progress,
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(Colors.blue),
                          backgroundColor: Colors.white,
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit.fill,
                      //   alignment: Alignment.center,
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        }
      },
    );
  }

  PageRouteBuilder<dynamic> transitions(Recommendations_Movie_Model movie) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return MoviesScreen(movieId: movie.id);
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }
}
