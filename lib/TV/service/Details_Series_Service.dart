import 'dart:convert';
import 'package:cinema_x/ApiConfig.dart';
import 'package:cinema_x/TV/model/Details_Series_Model.dart';
import 'package:http/http.dart' as http;

class TVShowService {
  Future<TVShowModel> getTVShow(int id) async {
    final response = await http.get(Uri.parse(
        '${ApiConfig.baseUrl}/tv/$id?api_key=${ApiConfig.apiKey}&language=en-US'));

    if (response.statusCode == 200) {
      return TVShowModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load TV show');
    }
  }
}
