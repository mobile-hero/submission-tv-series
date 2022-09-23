import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_season_episodes.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/episode.dart';

class MovieEpisodesNotifier extends ChangeNotifier {
  final GetSeasonEpisodes getSeasonEpisodes;

  MovieEpisodesNotifier({
    required this.getSeasonEpisodes,
  });

  List<Episode> _seasonEpisodes = [];

  List<Episode> get seasonEpisodes => _seasonEpisodes;

  RequestState _seasonState = RequestState.Empty;

  RequestState get seasonState => _seasonState;

  String _message = '';

  String get message => _message;

  Future<void> fetchSeasonEpisodes(int id, int seasonNumber) async {
    _seasonState = RequestState.Loading;
    notifyListeners();
    final episodesResult = await getSeasonEpisodes.execute(id, seasonNumber);
    episodesResult.fold(
      (failure) {
        _seasonState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (episodes) {
        _seasonState = RequestState.Loaded;
        _seasonEpisodes = episodes;
        notifyListeners();
      },
    );
  }
}
