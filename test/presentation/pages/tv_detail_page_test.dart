import 'package:ditonton/presentation/bloc/tv/detail/tv_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/watchlist/watchlist_tv_manager_bloc.dart';
import 'package:ditonton/presentation/pages/tv_detail_page.dart';
import 'package:ditonton/presentation/widgets/my_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects_tv.dart';
import 'tv_detail_page_test.mocks.dart';

@GenerateMocks([TvDetailBloc, WatchlistTvManagerBloc])
void main() {
  late MockTvDetailBloc mockBloc;
  late MockWatchlistTvManagerBloc mockWatchlistBloc;

  setUp(() {
    mockBloc = MockTvDetailBloc();
    mockWatchlistBloc = MockWatchlistTvManagerBloc();

    when(mockBloc.stream).thenAnswer((_) => Stream.value(TvDetailInitial()));
    when(mockWatchlistBloc.stream)
        .thenAnswer((_) => Stream.value(WatchlistTvManagerInitial()));
  });

  final detailBlocResult = TvDetailBlocResult(testTvDetail, []);

  Widget _makeTestableWidget(Widget body) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<TvDetailBloc>.value(
            value: mockBloc,
          ),
          BlocProvider<WatchlistTvManagerBloc>.value(
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
    when(mockBloc.state).thenAnswer((_) => TvDetailSuccess(detailBlocResult));
    when(mockWatchlistBloc.state)
        .thenAnswer((_) => WatchlistTvManagerSuccess(false, null));
    when(mockWatchlistBloc.isAddedToWatchlist).thenReturn(false);

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(
      id: 1,
    )));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display check icon when movie is added to watchlist',
      (WidgetTester tester) async {
    when(mockBloc.state).thenAnswer((_) => TvDetailSuccess(detailBlocResult));
    when(mockWatchlistBloc.state)
        .thenAnswer((_) => WatchlistTvManagerSuccess(true, null));
    when(mockWatchlistBloc.isAddedToWatchlist).thenReturn(true);

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(
      id: 1,
    )));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(mockWatchlistBloc.stream).thenAnswer((_) =>
        Stream.value(WatchlistTvManagerSuccess(true, 'Added to Watchlist')));
    when(mockBloc.state).thenAnswer((_) => TvDetailSuccess(detailBlocResult));
    when(mockWatchlistBloc.isAddedToWatchlist).thenReturn(false);
    when(mockWatchlistBloc.state).thenAnswer(
        (_) => WatchlistTvManagerSuccess(true, 'Added to Watchlist'));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(
      id: 1,
    )));

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
        (_) => Stream.value(WatchlistTvManagerError(false, 'Failed')));
    when(mockBloc.state).thenAnswer((_) => TvDetailSuccess(detailBlocResult));
    when(mockWatchlistBloc.isAddedToWatchlist).thenReturn(false);
    when(mockWatchlistBloc.state)
        .thenAnswer((_) => WatchlistTvManagerError(false, 'Failed'));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(
      id: 1,
    )));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton, warnIfMissed: false);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });

  testWidgets('$TvDetailPage should display MyProgressIndicator when Loading',
      (tester) async {
    when(mockBloc.state).thenAnswer((_) => TvDetailLoading());

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(
      id: 1,
    )));

    expect(find.byType(MyProgressIndicator), findsOneWidget);
  });

  testWidgets('$TvDetailPage should display text with message when Error',
      (WidgetTester tester) async {
    when(mockBloc.state).thenAnswer((_) => TvDetailError('Error message'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(
      id: 1,
    )));

    expect(textFinder, findsOneWidget);
  });
}
