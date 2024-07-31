class Video_Movies_model {
  final String? iso6391;
  final String? iso3166_1;
  final String? name;
  final String? key;
  final String? site;
  final int? size;
  final String? type;
  final bool? official;
  final DateTime? publishedAt;

  Video_Movies_model({
    this.iso6391,
    this.iso3166_1,
    this.name,
    this.key,
    this.site,
    this.size,
    this.type,
    this.official,
    this.publishedAt,
  });

  factory Video_Movies_model.fromJson(Map<String, dynamic> json) {
    return Video_Movies_model(
      iso6391: json['iso_639_1'] as String?,
      iso3166_1: json['iso_3166_1'] as String?,
      name: json['name'] as String?,
      key: json['key'] as String?,
      site: json['site'] as String?,
      size: json['size'] as int?,
      type: json['type'] as String?,
      official: json['official'] as bool?,
      publishedAt: json['published_at'] != null
          ? DateTime.tryParse(json['published_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'iso_639_1': iso6391,
      'iso_3166_1': iso3166_1,
      'name': name,
      'key': key,
      'site': site,
      'size': size,
      'type': type,
      'official': official,
      'published_at': publishedAt?.toIso8601String(),
    };
  }
}

class MovieVideoResponse {
  final int id;
  final List<Video_Movies_model> results;

  MovieVideoResponse({
    required this.id,
    required this.results,
  });

  factory MovieVideoResponse.fromJson(Map<String, dynamic> json) {
    var list = json['results'] as List<dynamic>? ?? [];
    List<Video_Movies_model> resultsList = list
        .map((i) => Video_Movies_model.fromJson(i as Map<String, dynamic>))
        .toList();

    return MovieVideoResponse(
      id: json['id'] as int? ?? 0,
      results: resultsList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'results': results.map((e) => e.toJson()).toList(),
    };
  }
}
