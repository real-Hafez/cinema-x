import 'package:cinema_x/ApiConfig.dart';
import 'package:cinema_x/Popular_peoble_movies_series/service/PopularSeries_service.dart';
import 'package:cinema_x/SearchPage/model/Search_Result_Model.dart';
import 'package:cinema_x/SearchPage/service/Search_Result_Service.dart';
import 'package:cinema_x/backdrop_poster_for_popular_and_For_you_movies_and_series/models/popular/popular_tmdb.dart';
import 'package:flutter/material.dart';

class TvSeriesScreen extends StatelessWidget {
  final int tvId;

  const TvSeriesScreen({super.key, required this.tvId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TV Series Screen')),
      body: FutureBuilder<SearchResultModel>(
        future: TMDbService().getseriesDetails(tvId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No series data'));
          } else {
            final series = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    series.name ?? 'No Title',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    series.releaseDate ?? 'No Release Date',
                    style: const TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(series.overview ?? 'No Overview'),
                  const SizedBox(height: 16),
                  if (series.posterPath != null)
                    Image.network(
                      '${ApiConfig.imageBaseUrl}${series.posterPath}',
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
