import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/movie/watchlist/watchlist_movie_manager_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_movie_manager_bloc_test.mocks.dart';

@GenerateMocks([GetWatchListStatus, SaveWatchlist, RemoveWatchlist])
main() {
  late MockGetWatchListStatus mockGetWatchlistStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetWatchlistStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
  });

  final int tId = 1;

  group("WatchlistMovieManagerBloc", () {
    blocTest<WatchlistMovieManagerBloc, WatchlistMovieManagerState>(
      "should get watchlist status from of a movie",
      setUp: () => when(mockGetWatchlistStatus.execute(tId))
          .thenAnswer((_) async => true),
      build: () => WatchlistMovieManagerBloc(
          mockGetWatchlistStatus, mockSaveWatchlist, mockRemoveWatchlist),
      act: (bloc) => bloc.add(RefreshWatchlistStatus(tId)),
      expect: () => [
        WatchlistMovieManagerLoading(),
        WatchlistMovieManagerSuccess(true, null)
      ],
    );

    blocTest<WatchlistMovieManagerBloc, WatchlistMovieManagerState>(
      "should change watchlist status to true",
      setUp: () {
        when(mockSaveWatchlist.execute(testMovieDetail)).thenAnswer((_) async =>
            Right(WatchlistMovieManagerBloc.watchlistAddSuccessMessage));
        when(mockGetWatchlistStatus.execute(tId)).thenAnswer((_) async => true);
      },
      build: () => WatchlistMovieManagerBloc(
          mockGetWatchlistStatus, mockSaveWatchlist, mockRemoveWatchlist),
      act: (bloc) => bloc.add(AddToWatchlist(testMovieDetail)),
      expect: () => [
        WatchlistMovieManagerLoading(),
        WatchlistMovieManagerSuccess(
            true, WatchlistMovieManagerBloc.watchlistAddSuccessMessage),
      ],
    );

    blocTest<WatchlistMovieManagerBloc, WatchlistMovieManagerState>(
      "should change watchlist status to false",
      setUp: () {
        when(mockRemoveWatchlist.execute(testMovieDetail)).thenAnswer(
            (_) async =>
                Right(WatchlistMovieManagerBloc.watchlistRemoveSuccessMessage));
        when(mockGetWatchlistStatus.execute(tId))
            .thenAnswer((_) async => false);
      },
      build: () => WatchlistMovieManagerBloc(
          mockGetWatchlistStatus, mockSaveWatchlist, mockRemoveWatchlist),
      act: (bloc) => bloc.add(RemoveFromWatchlist(testMovieDetail)),
      expect: () => [
        WatchlistMovieManagerLoading(),
        WatchlistMovieManagerSuccess(
            false, WatchlistMovieManagerBloc.watchlistRemoveSuccessMessage),
      ],
    );

    blocTest<WatchlistMovieManagerBloc, WatchlistMovieManagerState>(
      "should toggle watchlist status from false to true",
      setUp: () {
        when(mockSaveWatchlist.execute(testMovieDetail)).thenAnswer((_) async =>
            Right(WatchlistMovieManagerBloc.watchlistAddSuccessMessage));
        when(mockGetWatchlistStatus.execute(tId)).thenAnswer((_) async => true);
      },
      build: () {
        final bloc = WatchlistMovieManagerBloc(
            mockGetWatchlistStatus, mockSaveWatchlist, mockRemoveWatchlist);
        bloc.isAddedToWatchlist = false;
        return bloc;
      },
      act: (bloc) => bloc.add(ToggleWatchlist(testMovieDetail)),
      expect: () => [
        WatchlistMovieManagerLoading(),
        WatchlistMovieManagerSuccess(
            true, WatchlistMovieManagerBloc.watchlistAddSuccessMessage),
      ],
    );

    blocTest<WatchlistMovieManagerBloc, WatchlistMovieManagerState>(
      "should toggle watchlist status from true to false",
      setUp: () {
        when(mockRemoveWatchlist.execute(testMovieDetail)).thenAnswer(
            (_) async =>
                Right(WatchlistMovieManagerBloc.watchlistRemoveSuccessMessage));
        when(mockGetWatchlistStatus.execute(tId))
            .thenAnswer((_) async => false);
      },
      build: () {
        final bloc = WatchlistMovieManagerBloc(
            mockGetWatchlistStatus, mockSaveWatchlist, mockRemoveWatchlist);
        bloc.isAddedToWatchlist = true;
        return bloc;
      },
      act: (bloc) => bloc.add(ToggleWatchlist(testMovieDetail)),
      expect: () => [
        WatchlistMovieManagerLoading(),
        WatchlistMovieManagerSuccess(
            false, WatchlistMovieManagerBloc.watchlistRemoveSuccessMessage),
      ],
    );
  });
}
