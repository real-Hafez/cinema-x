import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cinema_x/ApiConfig.dart';
import 'package:cinema_x/for_you_row/model/for_you_model_movies.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class for_you_service_movies {
  for_you_service_movies._internal();
  static final for_you_service_movies _instance =
      for_you_service_movies._internal();
  factory for_you_service_movies() {
    return _instance;
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<int> favMoviesList = [];
  final Random _random = Random();

  Future<bool> _checkConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  Future<bool> checkConnection() {
    return _checkConnection();
  }

  Future<List<for_you_model_movies>> fetchMovies(int page) async {
    print('fetchMovies called');
    if (favMoviesList.isEmpty) {
      print('Favorite genres list is empty. Cannot fetch movies.');
      return [];
    }

    final hasInternet = await _checkConnection();
    if (!hasInternet) {
      print('No internet connection');
      //  throw Exception('No internet connection');
    }

    final randomGenreId = favMoviesList[_random.nextInt(favMoviesList.length)];
    print('Selected random genre ID: $randomGenreId');

    final url =
        '${ApiConfig.baseUrl}/discover/movie?include_adult=false&include_video=false&language=en-US&page=$page&sort_by=popularity.desc&with_genres=$randomGenreId&api_key=${ApiConfig.apiKey}';
    print('Request URL: $url');

    final response = await http.get(Uri.parse(url));
    print('Response status code: ${response.statusCode}');

    if (response.statusCode == 200) {
      print('Response: ${response.body}');
      final jsonData = json.decode(response.body);
      final List<dynamic> results = jsonData['results'];
      return results
          .map((movieJson) => for_you_model_movies.fromJson(movieJson))
          .toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<void> printUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');

    print('User email is: $email');
    if (email != null) {
      await _lookupUserInFirestore(email);
    }
  }

  Future<void> _lookupUserInFirestore(String email) async {
    try {
      final userDoc = await _firestore.collection('genra').doc(email).get();

      if (userDoc.exists) {
        final data = userDoc.data();
        print('User data: $data');

        final List<dynamic>? favGenres = data?['fav_genres'];
        if (favGenres != null && favGenres.isNotEmpty) {
          favMoviesList.clear();
          for (var genre in favGenres) {
            final int genreId = genre['id'];
            favMoviesList.add(genreId);
          }
          print('Favorite genres IDs: ${favMoviesList.join(',')}');

          // Randomly select two different indices
          final firstIndex = _random.nextInt(favMoviesList.length);
          int secondIndex;
          do {
            secondIndex = _random.nextInt(favMoviesList.length);
          } while (secondIndex == firstIndex);

          // Get the genres from the random indices
          final selectedGenres =
              '${favMoviesList[firstIndex]},${favMoviesList[secondIndex]}';
          print('Selected genres IDs: $selectedGenres');
        } else {
          print('No genres found in the list.');
        }
      } else {
        print('No user found with email: $email');
      }
    } catch (e) {
      print('Error fetching user from Firestore: $e');
    }
  }
}
