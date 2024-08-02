import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_x/ApiConfig.dart';
import 'package:cinema_x/Movies/Screen/Movies_Screen.dart';
import 'package:cinema_x/for_you_row/model/for_you_model_movies.dart';
import 'package:cinema_x/for_you_row/service/for_you_service_movies.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Ensure to include get package

class for_you_item extends StatefulWidget {
  const for_you_item({super.key, this.showAll = false});
  final bool showAll;

  @override
  State<for_you_item> createState() => _for_you_itemState();
}

class _for_you_itemState extends State<for_you_item> {
  late Future<List<for_you_model_movies>> futureMovies;
  final for_you_service_movies movieService = for_you_service_movies();

  @override
  void initState() {
    super.initState();
    futureMovies = Future.value([]);

    movieService.printUserEmail().then((_) {
      if (movieService.favMoviesList.isNotEmpty) {
        setState(() {
          futureMovies = movieService.fetchMovies(1);
        });
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:
          MediaQuery.of(context).size.height * 0.3, // Adjust height as needed
      child: FutureBuilder<List<for_you_model_movies>>(
        future: futureMovies,
        builder: (BuildContext context,
            AsyncSnapshot<List<for_you_model_movies>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Errorr: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'There was an error. Make sure you have an internet connection.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 24,
                ),
              ),
            );
          } else {
            final movies = snapshot.data!;
            return GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 1.2,
              ),
              physics: const BouncingScrollPhysics(),
              itemCount: movies.length,
              itemBuilder: (BuildContext context, int index) {
                final movie = movies[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(
                        MoviesScreen(
                          movieId: movie.id!,
                        ),
                        transition: Transition.circularReveal);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * .03,
                        vertical: MediaQuery.of(context).size.width * .0),
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
                      alignment: Alignment.center,
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
