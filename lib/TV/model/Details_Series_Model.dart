class TVShowModel {
  final bool? adult;
  final String? backdropPath;
  final List<Creator>? createdBy;
  final List<int>? episodeRunTime;
  final String? firstAirDate;
  final List<Genre>? genres;
  final String? homepage;
  final int id;
  final bool? inProduction;
  final List<String>? languages;
  final String? lastAirDate;
  final Episode? lastEpisodeToAir;
  final String? name;
  final Episode? nextEpisodeToAir;
  final List<Network>? networks;
  final int? numberOfEpisodes;
  final int? numberOfSeasons;
  final List<String>? originCountry;
  final String? originalLanguage;
  final String? originalName;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final List<ProductionCompany>? productionCompanies;
  final List<ProductionCountry>? productionCountries;
  final List<Season>? seasons;
  final List<SpokenLanguage>? spokenLanguages;
  final String? status;
  final String? tagline;
  final String? type;
  final double? voteAverage;
  final int? voteCount;

  TVShowModel({
    this.adult,
    this.backdropPath,
    this.createdBy,
    this.episodeRunTime,
    this.firstAirDate,
    this.genres,
    this.homepage,
    required this.id,
    this.inProduction,
    this.languages,
    this.lastAirDate,
    this.lastEpisodeToAir,
    this.name,
    this.nextEpisodeToAir,
    this.networks,
    this.numberOfEpisodes,
    this.numberOfSeasons,
    this.originCountry,
    this.originalLanguage,
    this.originalName,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.seasons,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.type,
    this.voteAverage,
    this.voteCount,
  });

  factory TVShowModel.fromJson(Map<String, dynamic> json) {
    return TVShowModel(
      adult: json['adult'],
      backdropPath: json['backdrop_path'],
      createdBy: (json['created_by'] as List<dynamic>?)
          ?.map((e) => Creator.fromJson(e as Map<String, dynamic>))
          .toList(),
      episodeRunTime: (json['episode_run_time'] as List<dynamic>?)
          ?.map((e) => e as int)
          .toList(),
      firstAirDate: json['first_air_date'],
      genres: (json['genres'] as List<dynamic>?)
          ?.map((e) => Genre.fromJson(e as Map<String, dynamic>))
          .toList(),
      homepage: json['homepage'],
      id: json['id'],
      inProduction: json['in_production'],
      languages: (json['languages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      lastAirDate: json['last_air_date'],
      lastEpisodeToAir: json['last_episode_to_air'] != null
          ? Episode.fromJson(json['last_episode_to_air'])
          : null,
      name: json['name'],
      nextEpisodeToAir: json['next_episode_to_air'] != null
          ? Episode.fromJson(json['next_episode_to_air'])
          : null,
      networks: (json['networks'] as List<dynamic>?)
          ?.map((e) => Network.fromJson(e as Map<String, dynamic>))
          .toList(),
      numberOfEpisodes: json['number_of_episodes'],
      numberOfSeasons: json['number_of_seasons'],
      originCountry: (json['origin_country'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      originalLanguage: json['original_language'],
      originalName: json['original_name'],
      overview: json['overview'],
      popularity: (json['popularity'] as num?)?.toDouble(),
      posterPath: json['poster_path'],
      productionCompanies: (json['production_companies'] as List<dynamic>?)
          ?.map((e) => ProductionCompany.fromJson(e as Map<String, dynamic>))
          .toList(),
      productionCountries: (json['production_countries'] as List<dynamic>?)
          ?.map((e) => ProductionCountry.fromJson(e as Map<String, dynamic>))
          .toList(),
      seasons: (json['seasons'] as List<dynamic>?)
          ?.map((e) => Season.fromJson(e as Map<String, dynamic>))
          .toList(),
      spokenLanguages: (json['spoken_languages'] as List<dynamic>?)
          ?.map((e) => SpokenLanguage.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'],
      tagline: json['tagline'],
      type: json['type'],
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      voteCount: json['vote_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adult': adult,
      'backdrop_path': backdropPath,
      'created_by': createdBy?.map((e) => e.toJson()).toList(),
      'episode_run_time': episodeRunTime,
      'first_air_date': firstAirDate,
      'genres': genres?.map((e) => e.toJson()).toList(),
      'homepage': homepage,
      'id': id,
      'in_production': inProduction,
      'languages': languages,
      'last_air_date': lastAirDate,
      'last_episode_to_air': lastEpisodeToAir?.toJson(),
      'name': name,
      'next_episode_to_air': nextEpisodeToAir?.toJson(),
      'networks': networks?.map((e) => e.toJson()).toList(),
      'number_of_episodes': numberOfEpisodes,
      'number_of_seasons': numberOfSeasons,
      'origin_country': originCountry,
      'original_language': originalLanguage,
      'original_name': originalName,
      'overview': overview,
      'popularity': popularity,
      'poster_path': posterPath,
      'production_companies':
          productionCompanies?.map((e) => e.toJson()).toList(),
      'production_countries':
          productionCountries?.map((e) => e.toJson()).toList(),
      'seasons': seasons?.map((e) => e.toJson()).toList(),
      'spoken_languages': spokenLanguages?.map((e) => e.toJson()).toList(),
      'status': status,
      'tagline': tagline,
      'type': type,
      'vote_average': voteAverage,
      'vote_count': voteCount,
    };
  }
}

class Creator {
  final int id;
  final String creditId;
  final String name;
  final String originalName;
  final int gender;
  final String? profilePath;

  Creator({
    required this.id,
    required this.creditId,
    required this.name,
    required this.originalName,
    required this.gender,
    this.profilePath,
  });

  factory Creator.fromJson(Map<String, dynamic> json) {
    return Creator(
      id: json['id'],
      creditId: json['credit_id'],
      name: json['name'],
      originalName: json['original_name'],
      gender: json['gender'],
      profilePath: json['profile_path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'credit_id': creditId,
      'name': name,
      'original_name': originalName,
      'gender': gender,
      'profile_path': profilePath,
    };
  }
}

class Genre {
  final int id;
  final String name;

  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class Episode {
  final int id;
  final String name;
  final String? overview;
  final double? voteAverage;
  final int? voteCount;
  final String? airDate;
  final int? episodeNumber;
  final String? episodeType;
  final String? productionCode;
  final int? runtime;
  final int? seasonNumber;
  final int? showId;
  final String? stillPath;

  Episode({
    required this.id,
    required this.name,
    this.overview,
    this.voteAverage,
    this.voteCount,
    this.airDate,
    this.episodeNumber,
    this.episodeType,
    this.productionCode,
    this.runtime,
    this.seasonNumber,
    this.showId,
    this.stillPath,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      id: json['id'],
      name: json['name'],
      overview: json['overview'],
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      voteCount: json['vote_count'],
      airDate: json['air_date'],
      episodeNumber: json['episode_number'],
      episodeType: json['episode_type'],
      productionCode: json['production_code'],
      runtime: json['runtime'],
      seasonNumber: json['season_number'],
      showId: json['show_id'],
      stillPath: json['still_path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'overview': overview,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'air_date': airDate,
      'episode_number': episodeNumber,
      'episode_type': episodeType,
      'production_code': productionCode,
      'runtime': runtime,
      'season_number': seasonNumber,
      'show_id': showId,
      'still_path': stillPath,
    };
  }
}

class Network {
  final int id;
  final String name;
  final String? logoPath;
  final String? originCountry;

  Network({
    required this.id,
    required this.name,
    this.logoPath,
    this.originCountry,
  });

  factory Network.fromJson(Map<String, dynamic> json) {
    return Network(
      id: json['id'],
      name: json['name'],
      logoPath: json['logo_path'],
      originCountry: json['origin_country'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'logo_path': logoPath,
      'origin_country': originCountry,
    };
  }
}

class ProductionCompany {
  final int id;
  final String name;
  final String? logoPath;
  final String? originCountry;

  ProductionCompany({
    required this.id,
    required this.name,
    this.logoPath,
    this.originCountry,
  });

  factory ProductionCompany.fromJson(Map<String, dynamic> json) {
    return ProductionCompany(
      id: json['id'],
      name: json['name'],
      logoPath: json['logo_path'],
      originCountry: json['origin_country'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'logo_path': logoPath,
      'origin_country': originCountry,
    };
  }
}

class ProductionCountry {
  final String iso31661;
  final String name;

  ProductionCountry({
    required this.iso31661,
    required this.name,
  });

  factory ProductionCountry.fromJson(Map<String, dynamic> json) {
    return ProductionCountry(
      iso31661: json['iso_3166_1'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'iso_3166_1': iso31661,
      'name': name,
    };
  }
}

class Season {
  final int id;
  final String name;
  final String? airDate;
  final int? episodeCount;
  final int? seasonNumber;
  final String? overview;
  final String? posterPath;
  final List<Episode>? episodes;

  Season({
    required this.id,
    required this.name,
    this.airDate,
    this.episodeCount,
    this.seasonNumber,
    this.overview,
    this.posterPath,
    this.episodes,
  });

  factory Season.fromJson(Map<String, dynamic> json) {
    return Season(
      id: json['id'],
      name: json['name'],
      airDate: json['air_date'],
      episodeCount: json['episode_count'],
      seasonNumber: json['season_number'],
      overview: json['overview'],
      posterPath: json['poster_path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'air_date': airDate,
      'episode_count': episodeCount,
      'season_number': seasonNumber,
      'overview': overview,
      'poster_path': posterPath,
    };
  }
}

class SpokenLanguage {
  final String iso6391;
  final String name;

  SpokenLanguage({
    required this.iso6391,
    required this.name,
  });

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) {
    return SpokenLanguage(
      iso6391: json['iso_639_1'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'iso_639_1': iso6391,
      'name': name,
    };
  }
}
