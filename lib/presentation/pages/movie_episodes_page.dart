import 'package:ditonton/injection.dart' as di;
import 'package:ditonton/presentation/widgets/episode_card.dart';
import 'package:ditonton/presentation/widgets/my_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/state_enum.dart';
import '../provider/movie_episodes_notifier.dart';
import '../widgets/error_message_container.dart';

class MovieEpisodesPage extends StatefulWidget {
  static const ROUTE_NAME = "/episodes";

  final int movieId;
  final int seasonNumber;
  final String seasonName;

  const MovieEpisodesPage({
    Key? key,
    required this.movieId,
    required this.seasonNumber,
    required this.seasonName,
  }) : super(key: key);

  @override
  State<MovieEpisodesPage> createState() => _MovieEpisodesPageState();
}

class _MovieEpisodesPageState extends State<MovieEpisodesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<MovieEpisodesNotifier>(context, listen: false)
          .fetchSeasonEpisodes(widget.movieId, widget.seasonNumber);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Episodes from ${widget.seasonName}'),
      ),
      body: Consumer<MovieEpisodesNotifier>(
        builder: (context, provider, child) {
          if (provider.seasonState == RequestState.Loading) {
            return MyProgressIndicator();
          } else if (provider.seasonState == RequestState.Loaded) {
            return SafeArea(
              child: ListView.builder(
                itemCount: provider.seasonEpisodes.length,
                itemBuilder: (context, position) {
                  final item = provider.seasonEpisodes[position];
                  return EpisodeCard(
                    key: ValueKey(item.episodeNumber),
                    episode: item,
                  );
                },
              ),
            );
          } else {
            return ErrorMessageContainer(message: provider.message);
          }
        },
      ),
    );
  }
}
