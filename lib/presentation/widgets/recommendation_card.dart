import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:flutter/material.dart';

import '../pages/movie_detail_page.dart';

class RecommendationCard extends StatelessWidget {
  final Movie movie;

  const RecommendationCard({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: () {
          Navigator.pushReplacementNamed(
            context,
            MovieDetailPage.ROUTE_NAME,
            arguments: movie.id,
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          child: CachedNetworkImage(
            imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
