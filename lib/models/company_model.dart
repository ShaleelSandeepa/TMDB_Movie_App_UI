class CompanyModel {
  int? id;
  String? logoPath;
  String? name;

  String? originCountry;

  CompanyModel({
    this.id,
    required this.logoPath,
    required this.name,
    this.originCountry,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      logoPath: json["logo_path"],
      name: json["name"],
    );
  }
}
