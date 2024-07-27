import 'dart:convert';
import 'package:cinema_x/ApiConfig.dart';
import 'package:cinema_x/Popular_peoble_movies_series/models/Popular_Series_model.dart';
import 'package:http/http.dart' as http;

class Popular_Series_Service {
  Future<List<Popular_Series_model>> getPopularSeries() async {
    final response = await http.get(Uri.parse(
        '${ApiConfig.baseUrl}/tv/popular?api_key=${ApiConfig.apiKey}'));
    if (response.statusCode == 200) {
      print('response for popular Movies: ${response.body}');

      final data = json.decode(response.body);
      final List<dynamic> results = data['results'];
      return results
          .map((json) => Popular_Series_model.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load popular movies');
    }
  }
}
