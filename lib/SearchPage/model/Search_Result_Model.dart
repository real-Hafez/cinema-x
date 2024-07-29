
class SearchResultModel {
  final int id;
  final String? name;
  final String? originalName;
  final String? title;
  final String? originalTitle;
  final String overview;
  final String backdropPath;
  final String posterPath;
  final String mediaType;
  final bool adult;
  final String originalLanguage;
  final List<int> genreIds;
  final double popularity;
  final double voteAverage;
  final int voteCount;
  final String? firstAirDate;
  final String? releaseDate;
  final List<String> originCountry;

  SearchResultModel({
    required this.id,
    this.name,
    this.originalName,
    this.title,
    this.originalTitle,
    required this.overview,
    required this.backdropPath,
    required this.posterPath,
    required this.mediaType,
    required this.adult,
    required this.originalLanguage,
    required this.genreIds,
    required this.popularity,
    required this.voteAverage,
    required this.voteCount,
    this.firstAirDate,
    this.releaseDate,
    required this.originCountry,
  });

  factory SearchResultModel.fromJson(Map<String, dynamic> json) {
    return SearchResultModel(
      id: json['id'],
      name: json['name'],
      originalName: json['original_name'],
      title: json['title'],
      originalTitle: json['original_title'],
      overview: json['overview'],
      backdropPath: json['backdrop_path'],
      posterPath: json['poster_path'],
      mediaType: json['media_type'],
      adult: json['adult'],
      originalLanguage: json['original_language'],
      genreIds: List<int>.from(json['genre_ids']),
      popularity: json['popularity'].toDouble(),
      voteAverage: json['vote_average'].toDouble(),
      voteCount: json['vote_count'],
      firstAirDate: json['first_air_date'],
      releaseDate: json['release_date'],
      originCountry: List<String>.from(json['origin_country']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'original_name': originalName,
      'title': title,
      'original_title': originalTitle,
      'overview': overview,
      'backdrop_path': backdropPath,
      'poster_path': posterPath,
      'media_type': mediaType,
      'adult': adult,
      'original_language': originalLanguage,
      'genre_ids': genreIds,
      'popularity': popularity,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'first_air_date': firstAirDate,
      'release_date': releaseDate,
      'origin_country': originCountry,
    };
  }

  static List<SearchResultModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => SearchResultModel.fromJson(json)).toList();
  }
}

class TmdbResponse {
  final int page;
  final List<SearchResultModel> results;

  TmdbResponse({
    required this.page,
    required this.results,
  });

  factory TmdbResponse.fromJson(Map<String, dynamic> json) {
    return TmdbResponse(
      page: json['page'],
      results: SearchResultModel.fromJsonList(json['results']),
    );
  }
}
