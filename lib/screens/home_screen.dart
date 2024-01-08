import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_movie_app_ui/models/movie_model.dart';
import 'package:tmdb_movie_app_ui/services/api_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ApiServices services = ApiServices();
  List<MovieModel>? movies = [];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    Color darkBlue = const Color(0xFF0d253f);
    Color lightBlue = const Color(0xFF01b4e4);
    Color lightGreen = const Color(0xFF90cea1);
    return Scaffold(
      backgroundColor: darkBlue,
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  Text(
                    "TMDB Movies",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Icon(
                    Icons.more_vert_rounded,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            Container(
              width: size.width * 0.9,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: TextField(
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search",
                            hintStyle: TextStyle(color: Colors.white38)),
                        cursorColor: lightBlue,
                      ),
                    ),
                    const Icon(
                      Icons.search_rounded,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 20,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            FutureBuilder(
              future: services.getPopularMovies(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  movies = snapshot.data!.cast<MovieModel>();
                  return CarouselSlider(
                    options: CarouselOptions(
                        height: size.height * 0.225, autoPlay: true),
                    items: movies!.map((movie) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        movie.backdropPath.toString()),
                                    colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.2),
                                        BlendMode.darken)),
                                color: lightBlue.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(15)),
                            child: Stack(children: [
                              Positioned(
                                bottom: 5,
                                left: 5,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.6),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 3, horizontal: 4),
                                        child: Center(
                                          child: Row(
                                            children: [
                                              Text(
                                                movie.voteAverage.toString(),
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                              const Icon(
                                                Icons.star_rate_rounded,
                                                color: Colors.amber,
                                                size: 18,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        // color: Colors.black.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      padding: const EdgeInsets.all(4.0),
                                      child: Text(
                                        movie.title
                                            .toString()
                                            .replaceAll(": ", " :\n"),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 5,
                                right: 5,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: lightBlue,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: const Center(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 3, horizontal: 6),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Watch now",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Icon(
                                            Icons.play_arrow_rounded,
                                            color: Colors.white,
                                            size: 18,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ]),
                          );
                        },
                      );
                    }).toList(),
                  );
                }
                return Padding(
                  padding: EdgeInsets.only(top: size.height * 0.1),
                  child: const CupertinoActivityIndicator(
                    color: Colors.white,
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
