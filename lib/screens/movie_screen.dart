import 'package:flutter/material.dart';
import 'package:tmdb_movie_app_ui/models/movie_model.dart';

class MovieScreen extends StatelessWidget {
  const MovieScreen({super.key, required this.movie});

  final MovieModel movie;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            width: size.width,
            height: size.height * 0.25,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(movie.backdropPath!), fit: BoxFit.cover),
            ),
            child: SafeArea(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(50)),
                      child:
                          const Center(child: BackButton(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
