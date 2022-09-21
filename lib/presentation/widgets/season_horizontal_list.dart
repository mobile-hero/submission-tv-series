import 'package:ditonton/presentation/widgets/season_card.dart';
import 'package:flutter/material.dart';

import '../../common/constants.dart';
import '../../domain/entities/season.dart';

class SeasonHorizontalList extends StatelessWidget {
  final List<Season> seasons;

  const SeasonHorizontalList({Key? key, required this.seasons})
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
              'Seasons',
              style: kHeading6,
            ),
          ),
          Container(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final season = seasons[index];
                return SeasonCard(season: season);
              },
              itemCount: seasons.length,
            ),
          ),
        ],
      ),
    );
  }
}
