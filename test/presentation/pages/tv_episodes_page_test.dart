import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/presentation/bloc/tv/episodes/tv_episodes_bloc.dart';
import 'package:ditonton/presentation/pages/tv_episodes_page.dart';
import 'package:ditonton/presentation/widgets/my_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_episodes_page_test.mocks.dart';

@GenerateMocks([TvEpisodesBloc])
void main() {
  late MockTvEpisodesBloc mockBloc;

  setUp(() {
    mockBloc = MockTvEpisodesBloc();
    when(mockBloc.stream).thenAnswer((_) => Stream.value(TvEpisodesInitial()));
  });

  Widget _makeTestableWidget(Widget body) {
    return MaterialApp(
      home: BlocProvider<TvEpisodesBloc>.value(
        value: mockBloc,
        child: Builder(builder: (context) {
          return body;
        }),
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
      '$TvEpisodesPage List should display one EpisodeCard when only one data source exist',
      (WidgetTester tester) async {
    when(mockBloc.state).thenAnswer((_) => TvEpisodesSuccess(tEpisodes));

    final episodeCard = find.byKey(ValueKey(tEpisode.episodeNumber));

    await tester.pumpWidget(_makeTestableWidget(TvEpisodesPage(
      movieId: 1,
      seasonName: 'seasonName',
      seasonNumber: 1,
    )));

    expect(episodeCard, findsOneWidget);
  });

  testWidgets('$TvEpisodesPage should display MyProgressIndicator when Loading',
      (tester) async {
    when(mockBloc.state).thenAnswer((_) => TvEpisodesLoading());

    await tester.pumpWidget(_makeTestableWidget(TvEpisodesPage(
      movieId: 1,
      seasonName: 'seasonName',
      seasonNumber: 1,
    )));

    expect(find.byType(MyProgressIndicator), findsOneWidget);
  });

  testWidgets('$TvEpisodesPage should display text with message when Error',
      (WidgetTester tester) async {
    when(mockBloc.state).thenAnswer((_) => TvEpisodesError('Error message'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TvEpisodesPage(
      movieId: 1,
      seasonName: 'seasonName',
      seasonNumber: 1,
    )));

    expect(textFinder, findsOneWidget);
  });
}
