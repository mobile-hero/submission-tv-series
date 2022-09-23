import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/utils.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/season.dart';
import 'my_progress_indicator.dart';

class SeasonCard extends StatelessWidget {
  final Season season;
  final Function(int seasonNumber, String seasonName) onTap;

  const SeasonCard({
    Key? key,
    required this.season,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () => onTap(season.seasonNumber, season.name),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 16),
              constraints: BoxConstraints(minWidth: 80, minHeight: 150),
              child: ClipRRect(
                child: CachedNetworkImage(
                  imageUrl: season.posterPath.imageUrl,
                  height: 150,
                  placeholder: (context, url) => Container(
                    color: Colors.white,
                    child: MyProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Container(
                    decoration: BoxDecoration(
                      color: Colors.red.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.error),
                  ),
                ),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 16.0),
              child: Text(season.name),
            ),
          ],
        ),
      ),
    );
  }
}
