import 'package:ditonton/injection.dart';
import 'package:ditonton/presentation/bloc/tv/episodes/tv_episodes_bloc.dart';
import 'package:ditonton/presentation/widgets/episode_card.dart';
import 'package:ditonton/presentation/widgets/my_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/error_message_container.dart';

class TvEpisodesPage extends StatefulWidget {
  static const ROUTE_NAME = "/episodes";

  final int movieId;
  final int seasonNumber;
  final String seasonName;

  const TvEpisodesPage({
    Key? key,
    required this.movieId,
    required this.seasonNumber,
    required this.seasonName,
  }) : super(key: key);

  @override
  State<TvEpisodesPage> createState() => _TvEpisodesPageState();
}

class _TvEpisodesPageState extends State<TvEpisodesPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator.get<TvEpisodesBloc>()
        ..add(GetEpisodesEvent(widget.movieId, widget.seasonNumber)),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Episodes from ${widget.seasonName}'),
        ),
        body: BlocBuilder<TvEpisodesBloc, TvEpisodesState>(
          builder: (context, state) {
            if (state is TvEpisodesLoading) {
              return MyProgressIndicator();
            } else if (state is TvEpisodesSuccess) {
              return SafeArea(
                child: ListView.builder(
                  itemCount: state.source.length,
                  itemBuilder: (context, position) {
                    final item = state.source[position];
                    return EpisodeCard(
                      key: ValueKey(item.episodeNumber),
                      episode: item,
                    );
                  },
                ),
              );
            } else if (state is TvEpisodesError) {
              return ErrorMessageContainer(message: state.message);
            } else {
              return SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
