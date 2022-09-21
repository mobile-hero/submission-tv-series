import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/utils.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/episode.dart';
import 'my_progress_indicator.dart';

class EpisodeCard extends StatelessWidget {
  final Episode season;

  const EpisodeCard({Key? key, required this.season}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            constraints: BoxConstraints(minWidth: 200, minHeight: 150),
            child: ClipRRect(
              child: CachedNetworkImage(
                imageUrl: season.stillPath.imageUrl,
                height: 150,
                placeholder: (context, url) => Container(
                  color: Colors.white,
                  child: MyProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Container(
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade200,
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
    );
  }
}
