import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_x/ApiConfig.dart';
import 'package:cinema_x/for_you_row/model/for_you_model_movies.dart';
import 'package:cinema_x/for_you_row/service/for_you_service_movies.dart';
import 'package:flutter/material.dart';

class for_you_item extends StatefulWidget {
  const for_you_item({super.key});

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
      if (movieService.Fav_movies_list.isNotEmpty) {
        setState(() {
          futureMovies = movieService.fetchMovies(1);
        });
      } else {
        print('No favorite genres available to fetch movies.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: FutureBuilder<List<for_you_model_movies>>(
            future: futureMovies,
            builder: (BuildContext context,
                AsyncSnapshot<List<for_you_model_movies>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No movies found.'));
              } else {
                final movies = snapshot.data!;
                return GridView.builder(
                  scrollDirection: Axis.horizontal,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 1.2,
                  ),
                  physics: const BouncingScrollPhysics(),
                  itemCount: movies.length.clamp(0, 7),
                  itemBuilder: (BuildContext context, int index) {
                    final movie = movies[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * .03),
                      child: CachedNetworkImage(
                        imageUrl:
                            '${ApiConfig.imageBaseUrl}${movie.posterPath}',
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                          child: CircularProgressIndicator(
                            value: downloadProgress.progress,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.blue),
                            backgroundColor: Colors.white,
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                        fit: BoxFit.fitWidth,
                        alignment: Alignment.center,
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
