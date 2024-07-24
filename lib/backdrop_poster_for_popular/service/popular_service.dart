import 'dart:convert';
import 'package:cinema_x/backdrop_poster_for_popular/ApiConfig.dart';
import 'package:cinema_x/backdrop_poster_for_popular/models/popular/popular_tmdb.dart';
import 'package:http/http.dart' as http;

class popularService {
  static Future<List<popular>> fetchPopular() async {
    const url =
        '${ApiConfig.baseUrl}/trending/all/day?language=en-US&api_key=${ApiConfig.apiKey}';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> results = data['results'];
        return results.map((json) => popular.fromJson(json)).toList();
      } else {
        print('Failed to fetch movies. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to fetch movies');
      }
    } catch (e) {
      print('Error occurred: $e');
      throw Exception('Failed to fetch movies');
    }
  }
}
