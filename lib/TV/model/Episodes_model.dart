class EpisodesModel {
  final bool adult;
  final String backdropPath;
  final List<Genre> genres;
  final String homepage;
  final int id;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String posterPath;
  final List<Season> seasons;
  final String status;
  final String type;
  final double voteAverage;
  final int voteCount;
  final SeasonDetails?
      seasonDetails; // Optional, as it may not always be present

  EpisodesModel({
    required this.adult,
    required this.backdropPath,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.seasons,
    required this.status,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
    this.seasonDetails,
  });

  factory EpisodesModel.fromJson(Map<String, dynamic> json) {
    return EpisodesModel(
      adult: json['adult'] ?? false,
      backdropPath: json['backdrop_path'] ?? '',
      genres: List<Genre>.from(json['genres'].map((x) => Genre.fromJson(x))),
      homepage: json['homepage'] ?? '',
      id: json['id'] ?? 0,
      originalLanguage: json['original_language'] ?? '',
      originalName: json['original_name'] ?? '',
      overview: json['overview'] ?? '',
      popularity: json['popularity']?.toDouble() ?? 0.0,
      posterPath: json['poster_path'] ?? '',
      seasons:
          List<Season>.from(json['seasons'].map((x) => Season.fromJson(x))),
      status: json['status'] ?? '',
      type: json['type'] ?? '',
      voteAverage: json['vote_average']?.toDouble() ?? 0.0,
      voteCount: json['vote_count'] ?? 0,
      seasonDetails: json.containsKey('season/1')
          ? SeasonDetails.fromJson(json['season/1'])
          : null,
    );
  }
}

class Genre {
  final int id;
  final String name;

  Genre({required this.id, required this.name});

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
    );
  }
}

class Season {
  final String airDate;
  final int episodeCount;
  final int id;
  final String name;
  final String overview;
  final String posterPath;
  final int seasonNumber;

  Season({
    required this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
  });

  factory Season.fromJson(Map<String, dynamic> json) {
    return Season(
      airDate: json['air_date'] ?? '',
      episodeCount: json['episode_count'] ?? 0,
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'] ?? '',
      seasonNumber: json['season_number'] ?? 0,
    );
  }
}

class Episode {
  final int id;
  final String airDate;
  final int episodeNumber;
  final String name;
  final String overview;
  final String posterPath;
  final double voteAverage;

  Episode({
    required this.id,
    required this.airDate,
    required this.episodeNumber,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      id: json['id'] ?? 0,
      airDate: json['air_date'] ?? '',
      episodeNumber: json['episode_number'] ?? 0,
      name: json['name'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['still_path'] ?? '',
      voteAverage: json['vote_average']?.toDouble() ?? 0.0,
    );
  }
}

class SeasonDetails {
  final String name;
  final String overview;
  final String posterPath;
  final int seasonNumber;
  final double voteAverage;
  final List<Episode> episodes;

  SeasonDetails({
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
    required this.voteAverage,
    required this.episodes,
  });

  factory SeasonDetails.fromJson(Map<String, dynamic> json) {
    return SeasonDetails(
      name: json['name'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'] ?? '',
      seasonNumber: json['season_number'] ?? 0,
      voteAverage: json['vote_average']?.toDouble() ?? 0.0,
      episodes:
          List<Episode>.from(json['episodes'].map((x) => Episode.fromJson(x))),
    );
  }
}
