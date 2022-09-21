import 'package:ditonton/presentation/widgets/recommendation_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/constants.dart';
import '../../common/state_enum.dart';
import '../../domain/entities/movie.dart';
import '../provider/movie_detail_notifier.dart';

class RecommendationHorizontalList extends StatelessWidget {
  final List<Movie> recommendations;

  const RecommendationHorizontalList({
    Key? key,
    required this.recommendations,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              'Recommendations',
              style: kHeading6,
            ),
          ),
          Consumer<MovieDetailNotifier>(
            builder: (context, data, child) {
              if (data.recommendationState == RequestState.Loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (data.recommendationState == RequestState.Error) {
                return Text(data.message);
              } else if (data.recommendationState == RequestState.Loaded) {
                return Container(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final movie = recommendations[index];
                      return RecommendationCard(movie: movie);
                    },
                    itemCount: recommendations.length,
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
