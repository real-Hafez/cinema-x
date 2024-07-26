import 'package:cinema_x/Popular_peoble_movies_series/models/Person_Model.dart';
import 'package:cinema_x/Popular_peoble_movies_series/models/Popular_movies_model.dart';
import 'package:cinema_x/Popular_peoble_movies_series/service/Person_service.dart';
import 'package:cinema_x/Popular_peoble_movies_series/service/Popular_movies_service.dart';
import 'package:cinema_x/Popular_peoble_movies_series/widgets/PopularMovies.dart';
import 'package:cinema_x/Popular_peoble_movies_series/widgets/Popular_Actors.dart';
import 'package:cinema_x/Popular_peoble_movies_series/widgets/for_you_popular.dart';
import 'package:cinema_x/Popular_peoble_movies_series/widgets/for_you_popular_movies.dart';
import 'package:flutter/material.dart';

class TrendingCoulm extends StatefulWidget {
  const TrendingCoulm({super.key});

  @override
  State<TrendingCoulm> createState() => _TrendingCoulmState();
}

class _TrendingCoulmState extends State<TrendingCoulm> {
  late Future<List<Person_Model>> _personModelFuture;
  late Future<List<Popular_Movies_model>> _popularMoviesFuture;

  @override
  void initState() {
    super.initState();
    _personModelFuture = PersonService().getPerson();
    _popularMoviesFuture = Popular_Movies_Service().getPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Person_Model>>(
      future: _personModelFuture,
      builder: (context, personSnapshot) {
        if (personSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (personSnapshot.hasError) {
          return Center(child: Text('Error: ${personSnapshot.error}'));
        } else if (personSnapshot.hasData) {
          final personModelList = personSnapshot.data!;

          return FutureBuilder<List<Popular_Movies_model>>(
            future: _popularMoviesFuture,
            builder: (context, moviesSnapshot) {
              if (moviesSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (moviesSnapshot.hasError) {
                return Center(child: Text('Error: ${moviesSnapshot.error}'));
              } else if (moviesSnapshot.hasData) {
                final popularMoviesList = moviesSnapshot.data!;

                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * .015),
                      child: const ForYouPopular(
                        textForRowOrMovie: 'Top Trending Actors',
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .01,
                    ),
                    PopularActors(
                      personModel: personModelList,
                    ),
                    const ForYouPopular_movies(
                      textForRowOrMovie: 'Popular Movies Now',
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .02),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .36,
                      child: Popularmovies(
                        popular_movie: popularMoviesList,
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    )
                  ],
                );
              } else {
                return const Center(child: Text('No data available'));
              }
            },
          );
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }
}
