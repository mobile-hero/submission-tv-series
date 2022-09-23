import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/presentation/pages/movie_episodes_page.dart';
import 'package:ditonton/presentation/provider/movie_episodes_notifier.dart';
import 'package:ditonton/presentation/widgets/my_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'movie_episodes_page_test.mocks.dart';

@GenerateMocks([MovieEpisodesNotifier])
void main() {
  late MockMovieEpisodesNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockMovieEpisodesNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<MovieEpisodesNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  final tEpisode = Episode(
    airDate: 'airDate',
    episodeNumber: 1,
    id: 1,
    name: 'name',
    overview: 'overview',
    runtime: 1,
    seasonNumber: 1,
    showId: 1,
    stillPath: 'stillPath',
    voteAverage: 1.0,
    voteCount: 1,
  );
  final tEpisodes = <Episode>[tEpisode];

  testWidgets(
      'List should display one EpisodeCard when only one data source exist',
      (WidgetTester tester) async {
    when(mockNotifier.seasonState).thenReturn(RequestState.Loaded);
    when(mockNotifier.seasonEpisodes).thenReturn(tEpisodes);

    final episodeCard = find.byKey(ValueKey(tEpisode.episodeNumber));

    await tester.pumpWidget(_makeTestableWidget(MovieEpisodesPage(
      movieId: 1,
      seasonName: 'seasonName',
      seasonNumber: 1,
    )));

    expect(episodeCard, findsOneWidget);
  });

  testWidgets('Page should display MyProgressIndicator when Loading',
      (tester) async {
    when(mockNotifier.seasonState).thenReturn(RequestState.Loading);
    when(mockNotifier.seasonEpisodes).thenReturn(<Episode>[]);

    await tester.pumpWidget(_makeTestableWidget(MovieEpisodesPage(
      movieId: 1,
      seasonName: 'seasonName',
      seasonNumber: 1,
    )));

    expect(find.byType(MyProgressIndicator), findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockNotifier.seasonState).thenReturn(RequestState.Error);
    when(mockNotifier.message).thenReturn('Error message');

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(MovieEpisodesPage(
      movieId: 1,
      seasonName: 'seasonName',
      seasonNumber: 1,
    )));

    expect(textFinder, findsOneWidget);
  });
}
