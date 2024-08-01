import 'dart:convert';
import 'package:cinema_x/ApiConfig.dart';
import 'package:cinema_x/Movies/model/detilis_model/detilis.dart';
import 'package:http/http.dart' as http;

class DetilisService {
  Future<Detilis?> fetchMoviesDetilis(int id) async {
    final String url =
        '${ApiConfig.baseUrl}/movie/$id?api_key=${ApiConfig.apiKey}&language=en-US';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return Detilis.fromJson(data);
      } else {
        print('Failed to load movie details: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Exception occurred: $e');
      return null;
    }
  }
}
