// tmdb_service.dart
import 'dart:convert';
import 'package:cinema_x/ApiConfig.dart';
import 'package:cinema_x/SearchPage/model/Search_Result_Model.dart';
import 'package:http/http.dart' as http;

class TMDbService {
  Future<List<SearchResultModel>> searchMedia(String query,) async {
    final response = await http.get(
      Uri.parse(
          '${ApiConfig.baseUrl}/search/multi?api_key=${ApiConfig.apiKey}&query=$query'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'] as List;

      results.sort((a, b) =>
          (b['popularity'] as double).compareTo(a['popularity'] as double));

      return results.map((json) => SearchResultModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load search results');
    }
    
  }
  Future<SearchResultModel> getMovieDetails(int movieId) async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}/movie/$movieId?api_key=${ApiConfig.apiKey}'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return SearchResultModel.fromJson(data);
    } else {
      throw Exception('Failed to load movie details');
    }
  }
}

// class SearchResultModel {
//   final String title;
//   final String releaseDate;
//   final String posterPath;

//   SearchResultModel(
//       {required this.title,
//       required this.releaseDate,
//       required this.posterPath});

//   factory SearchResultModel.fromJson(Map<String, dynamic> json) {
//     return SearchResultModel(
//       title: json['title'] ?? json['name'],
//       releaseDate: json['release_date'] ?? json['first_air_date'] ?? '',
//       posterPath: json['poster_path'] ?? '',
//     );
//   }
// }
