import 'dart:convert';
import 'package:cinema_x/ApiConfig.dart';
import 'package:cinema_x/Movies/model/Videos_model.dart';
import 'package:http/http.dart' as http;

class Video_Movies_Service {
  Future<List<Video_Movies_model>> fetchVideos(int movieId) async {
    final response = await http.get(
      Uri.parse(
          '${ApiConfig.baseUrl}/movie/$movieId/videos?api_key=${ApiConfig.apiKey}'),
    );
    print('API Response: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = jsonDecode(response.body);
      return parseVideos(responseBody);
    } else {
      throw Exception('Failed to load videos');
    }
  }

  List<Video_Movies_model> parseVideos(Map<String, dynamic> responseBody) {
    var list = responseBody['results'] as List<dynamic>;
    return list
        .map((i) => Video_Movies_model.fromJson(i as Map<String, dynamic>))
        .toList();
  }
}
