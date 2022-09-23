import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/utils.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/episode.dart';
import 'my_progress_indicator.dart';

class EpisodeCard extends StatelessWidget {
  final Episode episode;

  const EpisodeCard({Key? key, required this.episode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(minHeight: 40),
            child: ClipRRect(
              child: CachedNetworkImage(
                imageUrl: episode.stillPath.imageUrl,
                width: 120,
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      episode.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(episode.overview),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
