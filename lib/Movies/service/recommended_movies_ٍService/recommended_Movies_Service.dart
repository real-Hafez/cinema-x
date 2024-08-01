// movie_service.dart

import 'dart:convert';
import 'package:cinema_x/ApiConfig.dart';
import 'package:cinema_x/Movies/model/recommended_movies/recommended_Movies_model.dart';
import 'package:http/http.dart' as http;

class recommended_Movies_Service {
  Future<List<Recommendations_Movie_Model>> fetchMovies(int movieid) async {
    final response = await http.get(Uri.parse(
        '${ApiConfig.baseUrl}/movie/$movieid/recommendations?language=en-US&page=1&api_key=${ApiConfig.apiKey}'));
    print('fucking responce is {${response.body}');
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body)['results'];
      print(response.body);
      return body
          .map((dynamic item) => Recommendations_Movie_Model.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
