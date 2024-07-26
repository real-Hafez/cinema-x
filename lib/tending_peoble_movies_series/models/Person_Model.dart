class Person_Model {
  final int id;
  final String name;
  final String profilePath;
  final String knownForDepartment;
  final int gender;
  final double popularity;
  final List<KnownForItem> knownFor;

  Person_Model({
    required this.id,
    required this.name,
    required this.profilePath,
    required this.knownForDepartment,
    required this.gender,
    required this.popularity,
    required this.knownFor,
  });

  factory Person_Model.fromJson(Map<String, dynamic> json) {
    return Person_Model(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
      profilePath: json['profile_path'] ?? '',
      knownForDepartment: json['known_for_department'] ?? '',
      gender: json['gender'] ?? 0,
      popularity: (json['popularity'] ?? 0),
      knownFor: (json['known_for'] as List?)
              ?.map((item) => KnownForItem.fromJson(item))
              .toList() ??
          [],
    );
  }
}

class KnownForItem {
  final String title;
  final String overview;
  final String posterPath;

  KnownForItem({
    required this.title,
    required this.overview,
    required this.posterPath,
  });

  factory KnownForItem.fromJson(Map<String, dynamic> json) {
    return KnownForItem(
      title: json['title'] ?? json['name'],
      overview: json['overview'],
      posterPath: json['poster_path'],
    );
  }
}
