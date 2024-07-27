import 'dart:convert';

class Popular_Series_model {
  final String? backdropPath;
  final int? id;
  final String? name;
  final String? originalName;
  final String? overview;
  final String? posterPath;
  final String? mediaType;
  final bool? adult;
  final String? originalLanguage;
  final List<int>? genreIds;
  final double? popularity;
  final String? firstAirDate;
  final double? voteAverage;
  final int? voteCount;
  final List<String>? originCountry;

  Popular_Series_model({
    required this.backdropPath,
    required this.id,
    required this.name,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.mediaType,
    required this.adult,
    required this.originalLanguage,
    required this.genreIds,
    required this.popularity,
    required this.firstAirDate,
    required this.voteAverage,
    required this.voteCount,
    required this.originCountry,
  });

  factory Popular_Series_model.fromJson(Map<String, dynamic> json) {
    return Popular_Series_model(
      backdropPath: json['backdrop_path'],
      id: json['id'],
      name: json['name'],
      originalName: json['original_name'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      mediaType: json['media_type'],
      adult: json['adult'],
      originalLanguage: json['original_language'],
      genreIds: List<int>.from(json['genre_ids']),
      popularity: json['popularity'].toDouble(),
      firstAirDate: json['first_air_date'],
      voteAverage: json['vote_average'].toDouble(),
      voteCount: json['vote_count'],
      originCountry: List<String>.from(json['origin_country']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'backdrop_path': backdropPath,
      'id': id,
      'name': name,
      'original_name': originalName,
      'overview': overview,
      'poster_path': posterPath,
      'media_type': mediaType,
      'adult': adult,
      'original_language': originalLanguage,
      'genre_ids': genreIds,
      'popularity': popularity,
      'first_air_date': firstAirDate,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'origin_country': originCountry,
    };
  }
}

class TVShowResponse {
  final int totalPages;
  final int totalResults;
  final int page;
  final List<Popular_Series_model> results;

  TVShowResponse({
    required this.totalPages,
    required this.totalResults,
    required this.page,
    required this.results,
  });

  factory TVShowResponse.fromJson(Map<String, dynamic> json) {
    var resultsFromJson = json['results'] as List;
    List<Popular_Series_model> tvShowsList =
        resultsFromJson.map((i) => Popular_Series_model.fromJson(i)).toList();

    return TVShowResponse(
      totalPages: json['total_pages'],
      totalResults: json['total_results'],
      page: json['page'],
      results: tvShowsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_pages': totalPages,
      'total_results': totalResults,
      'page': page,
      'results': results.map((tvShow) => tvShow.toJson()).toList(),
    };
  }
}

void main() {
  String jsonString = '''{
  "total_pages": 1000,
  "total_results": 20000,
  "page": 1,
  "results": [
    {
      "backdrop_path": "/8hbXSjV5JvSjuSnOF2TBOAJEu5m.jpg",
      "id": 250162,
      "name": "The Decameron",
      "original_name": "The Decameron",
      "overview": "As the bubonic plague spreads through Italy, a group of nobles and servants retreats to a villa, where their lavish getaway quickly spirals into chaos.",
      "poster_path": "/7jxX4EQLeGMQb8SA4YgiaUowz8n.jpg",
      "media_type": "tv",
      "adult": false,
      "original_language": "en",
      "genre_ids": [
        35,
        18
      ],
      "popularity": 180.046,
      "first_air_date": "2024-07-25",
      "vote_average": 4.25,
      "vote_count": 8,
      "origin_country": [
        "US"
      ]
    }
  ]
}''';

  final jsonResponse = json.decode(jsonString);
  TVShowResponse response = TVShowResponse.fromJson(jsonResponse);

  print(response.results[0].name);
}
