import 'package:flutter/material.dart';
import 'package:cinema_x/Movies/widgets/movie_Screen_ui.dart';
import 'package:cinema_x/SearchPage/service/Search_Result_Service.dart';
import 'package:cinema_x/Movies/service/Videos_Service.dart';
import 'package:cinema_x/SearchPage/model/Search_Result_Model.dart';
import 'package:cinema_x/Movies/model/Videos_model.dart';

class MoviesScreen extends StatelessWidget {
  final int movieId;

  const MoviesScreen({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff090E17),
      body: SafeArea(
        child: FutureBuilder<SearchResultModel>(
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

              return FutureBuilder<List<Video_Movies_model>>(
                future: Video_Movies_Service().fetchVideos(movieId),
                builder: (context, videoSnapshot) {
                  if (videoSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (videoSnapshot.hasError) {
                    return Center(child: Text('Error: ${videoSnapshot.error}'));
                  } else if (!videoSnapshot.hasData ||
                      videoSnapshot.data!.isEmpty) {
                    return const Center(child: Text('No videos available'));
                  } else {
                    final videos = videoSnapshot.data!;
                    final trailers = videos
                        .where((video) => video.type == 'Trailer')
                        .toList();

                    if (trailers.isEmpty) {
                      return const Center(child: Text('No trailers available'));
                    }

                    final officialTrailers = trailers
                        .where((video) => (video.official ?? false))
                        .toList();
                    Video_Movies_model? selectedTrailer;
                    if (officialTrailers.isNotEmpty) {
                      officialTrailers.sort(
                          (a, b) => b.publishedAt!.compareTo(a.publishedAt!));
                      selectedTrailer = officialTrailers.first;
                    } else if (trailers.isNotEmpty) {
                      trailers.sort(
                          (a, b) => b.publishedAt!.compareTo(a.publishedAt!));
                      selectedTrailer = trailers.first;
                    } else {
                      return const Center(child: Text('No trailers available'));
                    }

                    const aspectRatio = 16 / 9;
                    final screenWidth = MediaQuery.of(context).size.width;
                    final videoHeight = screenWidth / aspectRatio;

                    return SingleChildScrollView(
                      child: movie_Screen_ui(
                        screenWidth: screenWidth,
                        videoHeight: videoHeight,
                        selectedTrailer: selectedTrailer,
                        trailers: trailers,
                        movie: movie,
                      ),
                    );
                  }
                },
              );
            }
          },
        ),
      ),
    );
  }
}
