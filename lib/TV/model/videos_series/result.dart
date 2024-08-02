class Result {
  String? iso6391;
  String? iso31661;
  String? name;
  String? key;
  DateTime? publishedAt;
  String? site;
  num? size;
  String? type;
  bool? official;
  int? id; // Change this to int?

  Result({
    this.iso6391,
    this.iso31661,
    this.name,
    this.key,
    this.publishedAt,
    this.site,
    this.size,
    this.type,
    this.official,
    this.id, // Change this to int?
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        iso6391: json['iso_639_1']?.toString(),
        iso31661: json['iso_3166_1']?.toString(),
        name: json['name']?.toString(),
        key: json['key']?.toString(),
        publishedAt: json['published_at'] == null
            ? null
            : DateTime.tryParse(json['published_at'].toString()),
        site: json['site']?.toString(),
        size: num.tryParse(json['size'].toString()),
        type: json['type']?.toString(),
        official: json['official']?.toString().contains("true"),
        id: json['id'] != null
            ? int.tryParse(json['id'].toString())
            : null, // Convert to int
      );

  Map<String, dynamic> toJson() => {
        if (iso6391 != null) 'iso_639_1': iso6391,
        if (iso31661 != null) 'iso_3166_1': iso31661,
        if (name != null) 'name': name,
        if (key != null) 'key': key,
        if (publishedAt != null) 'published_at': publishedAt?.toIso8601String(),
        if (site != null) 'site': site,
        if (size != null) 'size': size,
        if (type != null) 'type': type,
        if (official != null) 'official': official,
        if (id != null) 'id': id, // Ensure this is an int
      };
}
