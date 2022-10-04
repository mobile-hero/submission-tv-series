import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../domain/entities/tv_detail.dart';
import '../../../../domain/usecases/get_watchlist_tv_status.dart';
import '../../../../domain/usecases/tv_remove_watchlist.dart';
import '../../../../domain/usecases/tv_save_watchlist.dart';
import '../../common_states.dart';

part 'watchlist_tv_manager_event.dart';

part 'watchlist_tv_manager_state.dart';

class WatchlistTvManagerBloc
    extends Bloc<WatchlistTvManagerEvent, WatchlistTvManagerState> {
  final GetWatchListTvStatus getWatchListStatus;
  final TvSaveWatchlist saveWatchlist;
  final TvRemoveWatchlist removeWatchlist;

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  bool isAddedToWatchlist = false;

  WatchlistTvManagerBloc(
      this.getWatchListStatus, this.saveWatchlist, this.removeWatchlist)
      : super(WatchlistTvManagerInitial()) {
    on<RefreshWatchlistStatus>((event, emit) async {
      emit(WatchlistTvManagerLoading());
      final result = await getWatchListStatus.execute(event.id);
      this.isAddedToWatchlist = result;
      emit(WatchlistTvManagerSuccess(result, event.message));
    });
    on<AddToWatchlist>((event, emit) async {
      emit(WatchlistTvManagerLoading());
      final result = await saveWatchlist.execute(event.detail);
      result.fold(
        (failure) => emit(WatchlistTvManagerError(false, failure.message)),
        (success) {
          add(RefreshWatchlistStatus(
            event.detail.id,
            message: WatchlistTvManagerBloc.watchlistAddSuccessMessage,
          ));
        },
      );
    });
    on<RemoveFromWatchlist>((event, emit) async {
      emit(WatchlistTvManagerLoading());
      final result = await removeWatchlist.execute(event.detail);
      result.fold(
        (failure) => emit(WatchlistTvManagerError(false, failure.message)),
        (success) {
          add(RefreshWatchlistStatus(
            event.detail.id,
            message: WatchlistTvManagerBloc.watchlistRemoveSuccessMessage,
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
