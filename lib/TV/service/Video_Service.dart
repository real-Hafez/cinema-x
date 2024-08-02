// tmdb_service.dart
import 'dart:convert';
import 'package:cinema_x/ApiConfig.dart';
import 'package:http/http.dart' as http;
import '../model/videos_series/result.dart';

class TMDbService {
  Future<Result> getSeriesDetails(int seriesId) async {
    final response = await http.get(Uri.parse(
        '${ApiConfig.baseUrl}/tv/$seriesId?api_key=${ApiConfig.apiKey}&language=en-US'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return Result.fromJson(data);
    } else {
      throw Exception(
          'Failed to load series details. Status code: ${response.statusCode}');
    }
  }

  Future<List<Result>> fetchVideosSeries(int seriesId) async {
    final response = await http.get(Uri.parse(
        '${ApiConfig.baseUrl}/tv/$seriesId/videos?api_key=${ApiConfig.apiKey}&language=en-US'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['results'] ?? [];
      return results.map((json) => Result.fromJson(json)).toList();
    } else {
      throw Exception(
          'Failed to load videos. Status code: ${response.statusCode}');
    }
  }
}
