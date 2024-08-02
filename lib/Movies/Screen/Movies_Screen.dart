import 'package:auto_size_text/auto_size_text.dart';
import 'package:cinema_x/Movies/model/detilis_model/detilis.dart';
import 'package:cinema_x/Movies/service/detilis_service/detilis_service.dart';
import 'package:cinema_x/Movies/widgets/movie_Screen_ui.dart';
import 'package:cinema_x/SearchPage/service/Search_Result_Service.dart';
import 'package:cinema_x/Movies/service/Videos_Service.dart';
import 'package:cinema_x/SearchPage/model/Search_Result_Model.dart';
import 'package:cinema_x/Movies/model/Videos_model.dart';
import 'package:flutter/material.dart';

class MoviesScreen extends StatefulWidget {
  final int movieId;

  const MoviesScreen({super.key, required this.movieId});

  @override
  _MoviesScreenState createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  Video_Movies_model? selectedTrailer;
  List<Video_Movies_model> trailers = [];
  String movieName = 'Loading...'; // Placeholder for the movie name

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final movie = await search_service().getMovieDetails(widget.movieId);
      final detilis = await DetilisService().fetchMoviesDetilis(widget.movieId);
      final videoList =
          await Video_Movies_Service().fetchVideos(widget.movieId);

      final trailerList =
          videoList.where((video) => video.type == 'Trailer').toList();
      if (trailerList.isNotEmpty) {
        final officialTrailers =
            trailerList.where((video) => (video.official ?? false)).toList();
        if (officialTrailers.isNotEmpty) {
          officialTrailers
              .sort((a, b) => b.publishedAt!.compareTo(a.publishedAt!));
          selectedTrailer = officialTrailers.first;
        } else {
          trailerList.sort((a, b) => b.publishedAt!.compareTo(a.publishedAt!));
          selectedTrailer = trailerList.first;
        }
        trailers = trailerList;
      }

      if (selectedTrailer == null && trailers.isNotEmpty) {
        selectedTrailer = trailers.first;
      }

      // Set the movie name
      setState(() {
        movieName = movie.title!;
      });
    } catch (e) {
      print('Error loading data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff090E17),
      appBar: AppBar(
        surfaceTintColor: Colors.black,
        shadowColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: const Color(0xff090E17),
        title: AutoSizeText(
          movieName,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder<SearchResultModel>(
          future: search_service().getMovieDetails(widget.movieId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('No movie data'));
            } else {
              final movie = snapshot.data!;

              return FutureBuilder<Detilis?>(
                future: DetilisService().fetchMoviesDetilis(widget.movieId),
                builder: (context, detilisSnapshot) {
                  if (detilisSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (detilisSnapshot.hasError) {
                    return Center(
                        child: Text('Errorrr: ${detilisSnapshot.error}'));
                  } else if (!detilisSnapshot.hasData) {
                    return const Center(
                        child: Text('No additional details available'));
                  } else {
                    final detilis = detilisSnapshot.data!;

                    return SingleChildScrollView(
                      child: movie_Screen_ui(
                        screenWidth: MediaQuery.of(context).size.width,
                        videoHeight:
                            MediaQuery.of(context).size.width / (16 / 9),
                        trailers: trailers,
                        movie: movie,
                        detilis: detilis,
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

  /*

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: const Color(0xff090E17),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              backgroundColor: const Color(0xff090E17),
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                  movieName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
                background: Image.network(
                  'https://via.placeholder.com/800x400', // Replace with actual image URL
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverFillRemaining(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'Movie Details Here',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
  }

  */
