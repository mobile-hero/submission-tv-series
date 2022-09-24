import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/tv_series.dart';
import 'movie_card_list.dart';

class TvList extends StatelessWidget {
  final List<TvSeries> movies;

  const TvList({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final movie = movies[index];
        return TvCard(movie);
      },
      itemCount: movies.length,
    );
  }
}
