import 'package:tmdb_movie_app_ui/models/company_model.dart';
import 'package:tmdb_movie_app_ui/models/genres_model.dart';

class MovieDetailsModel {
  String? overview;
  List<CompanyModel>? companies;
  String? tagline;
  List<GenresModel>? genres;

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

    List<GenresModel> genres =
        (map["genres"] as List).map((e) => GenresModel.fromJson(e)).toList();

    return MovieDetailsModel(
      companies: companies,
      overview: map["overview"],
      tagline: map["tagline"] ?? "",
      genres: genres,
    );
  }
}
