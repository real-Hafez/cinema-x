import 'package:flutter/material.dart';
import 'package:cinema_x/Movies/service/Videos_Service.dart';
import 'package:cinema_x/SearchPage/model/Search_Result_Model.dart';
import 'package:cinema_x/SearchPage/service/Search_Result_Service.dart';
import 'package:cinema_x/Movies/model/Videos_model.dart';

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

            // Debug print for movie data
            print('Movie Title: ${movie.title}');
            print('Movie ID: $movieId');

            // Fetch videos for the movie
            return FutureBuilder<List<Video_Movies_model>>(
              future: Video_Movies_Service().fetchVideos(movieId),
              builder: (context, videoSnapshot) {
                if (videoSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (videoSnapshot.hasError) {
                  return Center(child: Text('Error: ${videoSnapshot.error}'));
                } else if (!videoSnapshot.hasData ||
                    videoSnapshot.data!.isEmpty) {
                  return const Center(child: Text('No videos available'));
                } else {
                  final videos = videoSnapshot.data!;

                  // Print video keys
                  print('Video Keys:');
                  if (videos.isEmpty) {
                    print('No videos available');
                  } else {
                    for (var video in videos) {
                      print('Video Name: ${video.name}');
                      print('Video Key: ${video.key}');
                    }
                  }

                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      color: Colors.green,
                      height: MediaQuery.of(context).size.height * .4,
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          'Movie: ${movie.title}\nVideos: ${videos.length}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
