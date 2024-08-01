class SpokenLanguage {
  String? englishName;
  String? iso6391;
  String? name;

  SpokenLanguage({this.englishName, this.iso6391, this.name});

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) {
    return SpokenLanguage(
      englishName: json['english_name']?.toString(),
      iso6391: json['iso_639_1']?.toString(),
      name: json['name']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        if (englishName != null) 'english_name': englishName,
        if (iso6391 != null) 'iso_639_1': iso6391,
        if (name != null) 'name': name,
      };
}
