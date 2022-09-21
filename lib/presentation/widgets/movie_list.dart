import 'package:flutter/material.dart';

import '../../domain/entities/movie.dart';
import 'movie_card_list.dart';

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final movie = movies[index];
        return MovieCard(movie);
      },
      itemCount: movies.length,
    );
  }
}
