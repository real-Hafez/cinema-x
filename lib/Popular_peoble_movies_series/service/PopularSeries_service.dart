import 'dart:convert';
import 'dart:io';
import 'package:cinema_x/ApiConfig.dart';
import 'package:cinema_x/Popular_peoble_movies_series/models/Popular_Series_model.dart';
import 'package:http/http.dart' as http;

class Popular_Series_Service {
  Future<bool> _checkConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  Future<List<Popular_Series_model>> getPopularSeries(int tvId) async {
    final hasInternet = await _checkConnection();
    if (!hasInternet) {
      print('No internet connection');
      return [];
    }

    const url = '${ApiConfig.baseUrl}/tv/popular?api_key=${ApiConfig.apiKey}';
    print('Request URL: $url');

    try {
      final response = await http.get(Uri.parse(url));
      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        print('Response for popular Series: ${response.body}');

        final data = json.decode(response.body);
        final List<dynamic> results = data['results'];
        return results
            .map((json) => Popular_Series_model.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load popular series');
      }
    } on SocketException catch (e) {
      print('SocketException: $e');
      return [];
    } on HttpException catch (e) {
      print('HttpException: $e');
      return [];
    } on FormatException catch (e) {
      print('FormatException: $e');
      return [];
    } catch (e) {
      print('Unexpected errorr: $e');
      return [];
    }
  }
}
