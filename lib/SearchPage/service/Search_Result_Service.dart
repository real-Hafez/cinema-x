// tmdb_service.dart
import 'dart:convert';
import 'package:cinema_x/ApiConfig.dart';
import 'package:http/http.dart' as http;

class TMDbService {
  final String apiKey = 'YOUR_TMDB_API_KEY';

  Future<List<MediaItem>> searchMedia(String query) async {
    final response = await http.get(
      Uri.parse(
          '${ApiConfig.baseUrl}/search/multi?api_key=${ApiConfig.apiKey}&query=$query'),
    );

        if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'] as List;

      results.sort((a, b) => (b['popularity'] as double).compareTo(a['popularity'] as double));

      return results.map((json) => MediaItem.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load search results');
    }

  }
}

class MediaItem {
  final String title;
  final String releaseDate;
  final String posterPath;

  MediaItem(
      {required this.title,
      required this.releaseDate,
      required this.posterPath});

  factory MediaItem.fromJson(Map<String, dynamic> json) {
    return MediaItem(
      title: json['title'] ?? json['name'],
      releaseDate: json['release_date'] ?? json['first_air_date'] ?? '',
      posterPath: json['poster_path'] ?? '',
    );
  }
}
