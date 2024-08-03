import 'dart:convert';
import 'package:cinema_x/ApiConfig.dart';
import 'package:cinema_x/backdrop_poster_for_popular_and_For_you_movies_and_series/models/popular/popular_tmdb.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';

class popularService {
  static Future<List<popular>> fetchPopular() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      throw Exception('No internet connection');
    }

    const url =
        '${ApiConfig.baseUrl}/trending/all/day?language=en-US&api_key=${ApiConfig.apiKey}';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> results = data['results'];
        return results.map((json) => popular.fromJson(json)).toList();
      } else {
        // Server responded with a status code that is not 200 OK
        throw Exception(
            'Failed to fetch movies. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Catch any errors (including connectivity issues)
      print('Error occurred: $e');
      throw Exception('Failed to fetch movies: $e');
    }
  }
}
