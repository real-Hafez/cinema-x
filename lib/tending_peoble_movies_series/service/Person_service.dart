import 'dart:convert';
import 'package:cinema_x/ApiConfig.dart';
import 'package:cinema_x/tending_peoble_movies_series/models/Person_Model.dart';
import 'package:http/http.dart' as http;

class PersonService {
  Future<List<Person_Model>> getPerson() async {
    final response = await http.get(Uri.parse(
        '${ApiConfig.baseUrl}/person/popular?language=en-US&page=1&api_key=${ApiConfig.apiKey}'));
    if (response.statusCode == 200) {
      print('response for actors: ${response.body}');

      final data = json.decode(response.body);
      final List<dynamic> results = data['results'];
      return results.map((json) => Person_Model.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load person');
    }
  }
}
