import 'dart:convert';
import 'package:cinema_x/ApiConfig.dart';
import 'package:cinema_x/TV/model/Episodes_model.dart';
import 'package:http/http.dart' as http;

class EpisodesService {
  Future<SeasonDetails> fetchTVShowDetails(
      int seriesId, int seasonNumber) async {
    final url =
        '${ApiConfig.baseUrl}/tv/$seriesId/season/$seasonNumber?api_key=${ApiConfig.apiKey}';
    print('Fetching details from URL: $url');

    final response = await http.get(Uri.parse(url));

    print('Response status code: ${response.statusCode}');
    if (response.statusCode == 200) {
      print('Response body: ${response.body}');
      return SeasonDetails.fromJson(jsonDecode(response.body));
    } else {
      print(
          'Failed to load TV show details. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Failed to load TV show details');
    }
  }
}
