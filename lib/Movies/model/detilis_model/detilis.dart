import 'genre.dart';
import 'production_company.dart';
import 'production_country.dart';
import 'spoken_language.dart';

class Detilis {
  bool? adult;
  String? backdropPath;
  dynamic belongsToCollection;
  num? budget;
  List<Genre>? genres;
  String? homepage;
  int? id;
  String? imdbId;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  num? popularity;
  String? posterPath;
  List<ProductionCompany>? productionCompanies;
  List<ProductionCountry>? productionCountries;
  String? releaseDate;
  num? revenue;
  num? runtime;
  List<SpokenLanguage>? spokenLanguages;
  String? status;
  String? tagline;
  String? title;
  bool? video;
  num? voteAverage;
  num? voteCount;

  Detilis({
    this.adult,
    this.backdropPath,
    this.belongsToCollection,
    this.budget,
    this.genres,
    this.homepage,
    this.id,
    this.imdbId,
    this.originCountry,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
  });

  factory Detilis.fromJson(Map<String, dynamic> json) => Detilis(
        adult: json['adult']?.toString().contains("true"),
        backdropPath: json['backdrop_path']?.toString(),
        belongsToCollection: json['belongs_to_collection'],
        budget: num.tryParse(json['budget'].toString()),
        genres: (json['genres'] as List<dynamic>?)
            ?.map((e) => Genre.fromJson(Map<String, dynamic>.from(e)))
            .toList(),
        homepage: json['homepage']?.toString(),
        id: int.tryParse(json['id'].toString()),
        imdbId: json['imdb_id']?.toString(),
        originCountry: List<String>.from(json['origin_country'] ?? []),
        originalLanguage: json['original_language']?.toString(),
        originalTitle: json['original_title']?.toString(),
        overview: json['overview']?.toString(),
        popularity: num.tryParse(json['popularity'].toString()),
        posterPath: json['poster_path']?.toString(),
        productionCompanies: (json['production_companies'] as List<dynamic>?)
            ?.map(
                (e) => ProductionCompany.fromJson(Map<String, dynamic>.from(e)))
            .toList(),
        productionCountries: (json['production_countries'] as List<dynamic>?)
            ?.map(
                (e) => ProductionCountry.fromJson(Map<String, dynamic>.from(e)))
            .toList(),
        releaseDate: json['release_date']?.toString(),
        revenue: num.tryParse(json['revenue'].toString()),
        runtime: num.tryParse(json['runtime'].toString()),
        spokenLanguages: (json['spoken_languages'] as List<dynamic>?)
            ?.map((e) => SpokenLanguage.fromJson(Map<String, dynamic>.from(e)))
            .toList(),
        status: json['status']?.toString(),
        tagline: json['tagline']?.toString(),
        title: json['title']?.toString(),
        video: json['video']?.toString().contains("true"),
        voteAverage: num.tryParse(json['vote_average'].toString()),
        voteCount: num.tryParse(json['vote_count'].toString()),
      );

  Map<String, dynamic> toJson() => {
        if (adult != null) 'adult': adult,
        if (backdropPath != null) 'backdrop_path': backdropPath,
        if (belongsToCollection != null)
          'belongs_to_collection': belongsToCollection,
        if (budget != null) 'budget': budget,
        if (genres != null) 'genres': genres?.map((e) => e.toJson()).toList(),
        if (homepage != null) 'homepage': homepage,
        if (id != null) 'id': id,
        if (imdbId != null) 'imdb_id': imdbId,
        if (originCountry != null) 'origin_country': originCountry,
        if (originalLanguage != null) 'original_language': originalLanguage,
        if (originalTitle != null) 'original_title': originalTitle,
        if (overview != null) 'overview': overview,
        if (popularity != null) 'popularity': popularity,
        if (posterPath != null) 'poster_path': posterPath,
        if (productionCompanies != null)
          'production_companies':
              productionCompanies?.map((e) => e.toJson()).toList(),
        if (productionCountries != null)
          'production_countries':
              productionCountries?.map((e) => e.toJson()).toList(),
        if (releaseDate != null) 'release_date': releaseDate,
        if (revenue != null) 'revenue': revenue,
        if (runtime != null) 'runtime': runtime,
        if (spokenLanguages != null)
          'spoken_languages': spokenLanguages?.map((e) => e.toJson()).toList(),
        if (status != null) 'status': status,
        if (tagline != null) 'tagline': tagline,
        if (title != null) 'title': title,
        if (video != null) 'video': video,
        if (voteAverage != null) 'vote_average': voteAverage,
        if (voteCount != null) 'vote_count': voteCount,
      };
}
