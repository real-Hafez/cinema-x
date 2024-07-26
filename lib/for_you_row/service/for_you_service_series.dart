import 'dart:convert';
import 'dart:math';
import 'package:cinema_x/ApiConfig.dart';
import 'package:cinema_x/for_you_row/model/for_you_model_series.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class for_you_service_series {
  for_you_service_series._internal();
  static final for_you_service_series _instance =
      for_you_service_series._internal();
  factory for_you_service_series() {
    return _instance;
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<int> Fav_series_list = [];
  final Random _random = Random();

  Future<List<for_you_model_series>> fetchseries(int page) async {
    print('fetchseries called');
    if (Fav_series_list.isEmpty) {
      print('Favorite genres list is empty. Cannot fetch series.');
      return [];
    }

    final randomGenreId =
        Fav_series_list[_random.nextInt(Fav_series_list.length)];
    print('Selected random genre ID from series: $randomGenreId');

    final url =
        '${ApiConfig.baseUrl}/discover/tv?include_adult=false&include_video=false&language=en-US&page=$page&sort_by=popularity.desc&with_genres=$randomGenreId&api_key=${ApiConfig.apiKey}';
    print('Request URL: $url');

    final response = await http.get(Uri.parse(url));
    print('Response status code:Firestore ${response.statusCode}');

    if (response.statusCode == 200) {
      print('Response: ${response.body}');
      final jsonData = json.decode(response.body);
      final List<dynamic> results = jsonData['results'];
      return results
          .map((seriesJson) => for_you_model_series.fromJson(seriesJson))
          .toList();
    } else {
      throw Exception('Failed to load series');
    }
  }

  Future<void> printUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');

    print('User email is: $email');
    if (email != null) {
      await _lookupUserInFirestore(email);
    }
  }

  Future<void> _lookupUserInFirestore(String email) async {
    try {
      final userDoc = await _firestore.collection('genra').doc(email).get();

      if (userDoc.exists) {
        final data = userDoc.data();
        print('User data: $data');

        final List<dynamic>? favGenres = data?['fav_genres'];
        if (favGenres != null && favGenres.isNotEmpty) {
          Fav_series_list.clear();
          for (var genre in favGenres) {
            final int genreId = genre['id_series'];
            Fav_series_list.add(genreId);
          }
          print(
              'Favorite genres IDs from series: ${Fav_series_list.join(',')}');

          final firstIndex = _random.nextInt(Fav_series_list.length);
          int secondIndex;
          do {
            secondIndex = _random.nextInt(Fav_series_list.length);
          } while (secondIndex == firstIndex);

          final selectedGenres =
              '${Fav_series_list[firstIndex]},${Fav_series_list[secondIndex]}';
          print('Selected genres IDs from sesries: $selectedGenres');
        } else {
          print('No genres found in the list.');
        }
      } else {
        print('No user found with email: $email');
      }
    } catch (e) {
      print('Error fetching user from Firestore: $e');
    }
  }
}
