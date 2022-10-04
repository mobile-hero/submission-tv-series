import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_status.dart';
import 'package:ditonton/domain/usecases/tv_remove_watchlist.dart';
import 'package:ditonton/domain/usecases/tv_save_watchlist.dart';
import 'package:ditonton/presentation/bloc/tv/watchlist/watchlist_tv_manager_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects_tv.dart';
import 'watchlist_tv_manager_bloc_test.mocks.dart';

@GenerateMocks([GetWatchListTvStatus, TvSaveWatchlist, TvRemoveWatchlist])
main() {
  late MockGetWatchListTvStatus mockGetWatchlistTvStatus;
  late MockTvSaveWatchlist mockTvSaveWatchlist;
  late MockTvRemoveWatchlist mockTvRemoveWatchlist;

  setUp(() {
    mockGetWatchlistTvStatus = MockGetWatchListTvStatus();
    mockTvSaveWatchlist = MockTvSaveWatchlist();
    mockTvRemoveWatchlist = MockTvRemoveWatchlist();
  });

  final int tId = 1;

  group("WatchlistTvManagerBloc", () {
    blocTest<WatchlistTvManagerBloc, WatchlistTvManagerState>(
      "should get watchlist status from of a tv series",
      setUp: () => when(mockGetWatchlistTvStatus.execute(tId))
          .thenAnswer((_) async => true),
      build: () => WatchlistTvManagerBloc(
          mockGetWatchlistTvStatus, mockTvSaveWatchlist, mockTvRemoveWatchlist),
      act: (bloc) => bloc.add(RefreshWatchlistStatus(tId)),
      expect: () =>
          [WatchlistTvManagerLoading(), WatchlistTvManagerSuccess(true, null)],
    );

    blocTest<WatchlistTvManagerBloc, WatchlistTvManagerState>(
      "should change watchlist status to true",
      setUp: () {
        when(mockTvSaveWatchlist.execute(testTvDetail)).thenAnswer((_) async =>
            Right(WatchlistTvManagerBloc.watchlistAddSuccessMessage));
        when(mockGetWatchlistTvStatus.execute(tId))
            .thenAnswer((_) async => true);
      },
      build: () => WatchlistTvManagerBloc(
          mockGetWatchlistTvStatus, mockTvSaveWatchlist, mockTvRemoveWatchlist),
      act: (bloc) => bloc.add(AddToWatchlist(testTvDetail)),
      expect: () => [
        WatchlistTvManagerLoading(),
        WatchlistTvManagerSuccess(
            true, WatchlistTvManagerBloc.watchlistAddSuccessMessage),
      ],
    );

    blocTest<WatchlistTvManagerBloc, WatchlistTvManagerState>(
      "should change watchlist status to false",
      setUp: () {
        when(mockTvRemoveWatchlist.execute(testTvDetail)).thenAnswer(
            (_) async =>
                Right(WatchlistTvManagerBloc.watchlistRemoveSuccessMessage));
        when(mockGetWatchlistTvStatus.execute(tId))
            .thenAnswer((_) async => false);
      },
      build: () => WatchlistTvManagerBloc(
          mockGetWatchlistTvStatus, mockTvSaveWatchlist, mockTvRemoveWatchlist),
      act: (bloc) => bloc.add(RemoveFromWatchlist(testTvDetail)),
      expect: () => [
        WatchlistTvManagerLoading(),
        WatchlistTvManagerSuccess(
            false, WatchlistTvManagerBloc.watchlistRemoveSuccessMessage),
      ],
    );

    blocTest<WatchlistTvManagerBloc, WatchlistTvManagerState>(
      "should toggle watchlist status from false to true",
      setUp: () {
        when(mockTvSaveWatchlist.execute(testTvDetail)).thenAnswer((_) async =>
            Right(WatchlistTvManagerBloc.watchlistAddSuccessMessage));
        when(mockGetWatchlistTvStatus.execute(tId))
            .thenAnswer((_) async => true);
      },
      build: () {
        final bloc = WatchlistTvManagerBloc(mockGetWatchlistTvStatus,
            mockTvSaveWatchlist, mockTvRemoveWatchlist);
        bloc.isAddedToWatchlist = false;
        return bloc;
      },
      act: (bloc) => bloc.add(ToggleWatchlist(testTvDetail)),
      expect: () => [
        WatchlistTvManagerLoading(),
        WatchlistTvManagerSuccess(
            true, WatchlistTvManagerBloc.watchlistAddSuccessMessage),
      ],
    );

    blocTest<WatchlistTvManagerBloc, WatchlistTvManagerState>(
      "should toggle watchlist status from true to false",
      setUp: () {
        when(mockTvRemoveWatchlist.execute(testTvDetail)).thenAnswer(
            (_) async =>
                Right(WatchlistTvManagerBloc.watchlistRemoveSuccessMessage));
        when(mockGetWatchlistTvStatus.execute(tId))
            .thenAnswer((_) async => false);
      },
      build: () {
        final bloc = WatchlistTvManagerBloc(mockGetWatchlistTvStatus,
            mockTvSaveWatchlist, mockTvRemoveWatchlist);
        bloc.isAddedToWatchlist = true;
        return bloc;
      },
      act: (bloc) => bloc.add(ToggleWatchlist(testTvDetail)),
      expect: () => [
        WatchlistTvManagerLoading(),
        WatchlistTvManagerSuccess(
            false, WatchlistTvManagerBloc.watchlistRemoveSuccessMessage),
      ],
    );
  });
}
