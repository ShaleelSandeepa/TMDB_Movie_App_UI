import 'package:tmdb_movie_app_ui/models/company_model.dart';

class MovieDetailsModel {
  String? overview;
  List<CompanyModel>? companies;
  String? tagline;
  List<Map<String, dynamic>>? genres;

  MovieDetailsModel({
    required this.companies,
    required this.overview,
    required this.tagline,
    required this.genres,
  });

  factory MovieDetailsModel.fromJson(Map<String, dynamic> map) {
    List<CompanyModel> companies = (map["production_companies"] as List)
        .map((company) => CompanyModel.fromJson(company))
        .toList();

    return MovieDetailsModel(
      companies: companies,
      overview: map["overview"],
      tagline: map["tagline"],
      genres: map["genres"] ?? "",
    );
  }
}
