import 'package:flutter/material.dart';

import '../../common/constants.dart';
import '../../domain/entities/episode.dart';
import 'episode_card.dart';

class EpisodeHorizontalList extends StatelessWidget {
  final List<Episode> seasons;

  const EpisodeHorizontalList({Key? key, required this.seasons})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              'Episodes',
              style: kHeading6,
            ),
          ),
          Container(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final season = seasons[index];
                return EpisodeCard(season: season);
              },
              itemCount: seasons.length,
            ),
          ),
        ],
      ),
    );
  }
}
