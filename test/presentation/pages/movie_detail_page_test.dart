import 'package:ditonton/presentation/bloc/movie/detail/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/watchlist/watchlist_movie_manager_bloc.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/widgets/my_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_page_test.mocks.dart';

@GenerateMocks([MovieDetailBloc, WatchlistMovieManagerBloc])
void main() {
  late MockMovieDetailBloc mockBloc;
  late MockWatchlistMovieManagerBloc mockWatchlistBloc;

  setUp(() {
    mockBloc = MockMovieDetailBloc();
    mockWatchlistBloc = MockWatchlistMovieManagerBloc();

    when(mockBloc.stream).thenAnswer((_) => Stream.value(MovieDetailInitial()));
    when(mockWatchlistBloc.stream)
        .thenAnswer((_) => Stream.value(WatchlistMovieManagerInitial()));
  });

  final detailBlocResult = MovieDetailBlocResult(testMovieDetail, []);

  Widget _makeTestableWidget(Widget body) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<MovieDetailBloc>.value(
            value: mockBloc,
          ),
          BlocProvider<WatchlistMovieManagerBloc>.value(
            value: mockWatchlistBloc,
          ),
        ],
        child: Builder(builder: (context) {
          return body;
        }),
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(mockBloc.state)
        .thenAnswer((_) => MovieDetailSuccess(detailBlocResult));
    when(mockWatchlistBloc.state)
        .thenAnswer((_) => WatchlistMovieManagerSuccess(false, null));
    when(mockWatchlistBloc.isAddedToWatchlist).thenReturn(false);

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display check icon when movie is added to watchlist',
      (WidgetTester tester) async {
    when(mockBloc.state)
        .thenAnswer((_) => MovieDetailSuccess(detailBlocResult));
    when(mockWatchlistBloc.state)
        .thenAnswer((_) => WatchlistMovieManagerSuccess(true, null));
    when(mockWatchlistBloc.isAddedToWatchlist).thenReturn(true);

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(mockWatchlistBloc.stream).thenAnswer((_) =>
        Stream.value(WatchlistMovieManagerSuccess(true, 'Added to Watchlist')));
    when(mockBloc.state)
        .thenAnswer((_) => MovieDetailSuccess(detailBlocResult));
    when(mockWatchlistBloc.isAddedToWatchlist).thenReturn(false);
    when(mockWatchlistBloc.state).thenAnswer(
        (_) => WatchlistMovieManagerSuccess(true, 'Added to Watchlist'));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(mockWatchlistBloc.stream).thenAnswer(
        (_) => Stream.value(WatchlistMovieManagerError(false, 'Failed')));
    when(mockBloc.state)
        .thenAnswer((_) => MovieDetailSuccess(detailBlocResult));
    when(mockWatchlistBloc.isAddedToWatchlist).thenReturn(false);
    when(mockWatchlistBloc.state)
        .thenAnswer((_) => WatchlistMovieManagerError(false, 'Failed'));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton, warnIfMissed: false);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });

  testWidgets(
      '$MovieDetailPage should display MyProgressIndicator when Loading',
      (tester) async {
    when(mockBloc.state).thenAnswer((_) => MovieDetailLoading());

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(
      id: 1,
    )));

    expect(find.byType(MyProgressIndicator), findsOneWidget);
  });

  testWidgets('$MovieDetailPage should display text with message when Error',
      (WidgetTester tester) async {
    when(mockBloc.state).thenAnswer((_) => MovieDetailError('Error message'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(
      id: 1,
    )));

    expect(textFinder, findsOneWidget);
  });
}
