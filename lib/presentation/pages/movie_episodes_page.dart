import 'package:ditonton/injection.dart' as di;
import 'package:ditonton/presentation/widgets/episode_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/state_enum.dart';
import '../provider/movie_episodes_notifier.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => di.locator<MovieEpisodesNotifier>()
        ..fetchSeasonEpisodes(widget.movieId, widget.seasonNumber),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Episodes from ${widget.seasonName}'),
        ),
        body: Consumer<MovieEpisodesNotifier>(
          builder: (context, provider, child) {
            if (provider.seasonState == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
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
              return Text(provider.message);
            }
          },
        ),
      ),
    );
  }
}
