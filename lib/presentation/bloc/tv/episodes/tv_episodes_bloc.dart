import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/usecases/get_season_episodes.dart';
import 'package:ditonton/presentation/bloc/common_states.dart';
import 'package:meta/meta.dart';

part 'tv_episodes_event.dart';

part 'tv_episodes_state.dart';

class TvEpisodesBloc extends Bloc<TvEpisodesEvent, TvEpisodesState> {
  final GetSeasonEpisodes getSeasonEpisodes;

  TvEpisodesBloc(this.getSeasonEpisodes) : super(TvEpisodesInitial()) {
    on<GetEpisodesEvent>((event, emit) async {
      emit(TvEpisodesLoading());
      final episodesResult =
          await getSeasonEpisodes.execute(event.tvId, event.season);
      episodesResult.fold(
        (failure) => emit(TvEpisodesError(failure.message)),
        (success) => emit(TvEpisodesSuccess(success)),
      );
    });
  }
}
