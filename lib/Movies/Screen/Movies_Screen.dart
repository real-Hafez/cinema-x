import 'package:cinema_x/ApiConfig.dart';
import 'package:flutter/material.dart';
import 'package:cinema_x/SearchPage/model/Search_Result_Model.dart';
import 'package:cinema_x/SearchPage/service/Search_Result_Service.dart';

class MoviesScreen extends StatelessWidget {
  final int movieId;

  const MoviesScreen({super.key, required this.movieId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Movies Screen')),
      body: FutureBuilder<SearchResultModel>(
        future: TMDbService().getMovieDetails(movieId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No movie data'));
          } else {
            final movie = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title ?? 'No Title',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    movie.releaseDate ?? 'No Release Date',
                    style: const TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(movie.overview ?? 'No Overview'),
                  const SizedBox(height: 16),
                  if (movie.posterPath != null)
                    Image.network(
                      '${ApiConfig.imageBaseUrl}${movie.posterPath}',
                      fit: BoxFit.cover,
                    ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
