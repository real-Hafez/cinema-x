import 'dart:convert';
import 'package:cinema_x/ApiConfig.dart';
import 'package:cinema_x/Popular_peoble_movies_series/models/Person_Model.dart';
import 'package:http/http.dart' as http;

class PersonService {
  Future<List<Person_Model>> getPerson() async {
    final response = await http.get(Uri.parse(
        '${ApiConfig.baseUrl}/person/popular?language=en-US&page=1&api_key=${ApiConfig.apiKey}'));

    if (response.statusCode == 200) {
      print('Response for actors: ${response.body}');

      final data = json.decode(response.body);
      final List<dynamic> results = data['results'];
      return results.map((json) => Person_Model.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load person');
    }
  }
}

class PersonDetailService {
  Future<Person_Model> getPersonDetail(int personId) async {
    final url = Uri.parse(
        '${ApiConfig.baseUrl}/person/$personId?language=en-US&api_key=${ApiConfig.apiKey}');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Log response for debugging
        print('Response for person details: ${response.body}');

        final data = json.decode(response.body);
        return Person_Model.fromJson(data);
      } else {
        // Detailed error handling
        final errorMessage = 'Failed to load person details. Status code: ${response.statusCode}';
        print(errorMessage);
        throw Exception(errorMessage);
      }
    } catch (e) {
      // Log and rethrow any errors
      print('Error fetching person details: $e');
      rethrow;
    }
  }
}
