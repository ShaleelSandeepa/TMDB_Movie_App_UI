import 'dart:convert';

import 'package:http/http.dart';
import 'package:logger/logger.dart';
import 'package:tmdb_movie_app_ui/models/movie_model.dart';

class ApiServices {
  String popularMovies = "https://api.themoviedb.org/3/movie/popular?";
  String apiKey = "api_key=6cd9949438a13c32f2b50d94ed4f22a0";

  Future<List> getPopularMovies() async {
    Response response = await get(Uri.parse("$popularMovies$apiKey"));
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      List<dynamic> results = body["results"];
      List<MovieModel> movies =
          results.map((movie) => MovieModel.fromJson(movie)).toList();
      return movies;
    } else {
      Logger().e(response.statusCode);
      return [];
    }
  }
}
