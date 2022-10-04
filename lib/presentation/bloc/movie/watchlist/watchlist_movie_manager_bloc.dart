import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/presentation/bloc/common_states.dart';
import 'package:meta/meta.dart';

import '../../../../domain/usecases/usecases.dart';

part 'watchlist_movie_manager_event.dart';

part 'watchlist_movie_manager_state.dart';

class WatchlistMovieManagerBloc
    extends Bloc<WatchlistMovieManagerEvent, WatchlistMovieManagerState> {
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  bool isAddedToWatchlist = false;

  WatchlistMovieManagerBloc(
      this.getWatchListStatus, this.saveWatchlist, this.removeWatchlist)
      : super(WatchlistMovieManagerInitial()) {
    on<RefreshWatchlistStatus>((event, emit) async {
      emit(WatchlistMovieManagerLoading());
      final result = await getWatchListStatus.execute(event.id);
      this.isAddedToWatchlist = result;
      emit(WatchlistMovieManagerSuccess(result, event.message));
    });
    on<AddToWatchlist>((event, emit) async {
      emit(WatchlistMovieManagerLoading());
      final result = await saveWatchlist.execute(event.detail);
      result.fold(
        (failure) => emit(WatchlistMovieManagerError(false, failure.message)),
        (success) {
          add(RefreshWatchlistStatus(
            event.detail.id,
            message: WatchlistMovieManagerBloc.watchlistAddSuccessMessage,
          ));
        },
      );
    });
    on<RemoveFromWatchlist>((event, emit) async {
      emit(WatchlistMovieManagerLoading());
      final result = await removeWatchlist.execute(event.detail);
      result.fold(
        (failure) => emit(WatchlistMovieManagerError(false, failure.message)),
        (success) {
          add(RefreshWatchlistStatus(
            event.detail.id,
            message: WatchlistMovieManagerBloc.watchlistRemoveSuccessMessage,
          ));
        },
      );
    });
    on<ToggleWatchlist>((event, emit) {
      if (isAddedToWatchlist) {
        add(RemoveFromWatchlist(event.detail));
      } else {
        add(AddToWatchlist(event.detail));
      }
    });
  }
}
