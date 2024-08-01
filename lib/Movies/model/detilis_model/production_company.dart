class ProductionCompany {
  num? id;
  String? logoPath;
  String? name;
  String? originCountry;

  ProductionCompany({
    this.id,
    this.logoPath,
    this.name,
    this.originCountry,
  });

  factory ProductionCompany.fromJson(Map<String, dynamic> json) {
    return ProductionCompany(
      id: num.tryParse(json['id'].toString()),
      logoPath: json['logo_path']?.toString(),
      name: json['name']?.toString(),
      originCountry: json['origin_country']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        if (logoPath != null) 'logo_path': logoPath,
        if (name != null) 'name': name,
        if (originCountry != null) 'origin_country': originCountry,
      };
}
