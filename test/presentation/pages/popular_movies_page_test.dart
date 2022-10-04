import 'package:ditonton/presentation/bloc/movie/popular/popular_movies_bloc.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_movies_page_test.mocks.dart';

@GenerateMocks([PopularMoviesBloc])
void main() {
  late MockPopularMoviesBloc mockBloc;

  setUp(() {
    mockBloc = MockPopularMoviesBloc();
    when(mockBloc.stream)
        .thenAnswer((_) => Stream.value(PopularMoviesInitial()));
  });

  Widget _makeTestableWidget(Widget body) {
    return MaterialApp(
      home: BlocProvider<PopularMoviesBloc>.value(
        value: mockBloc,
        child: Builder(builder: (context) {
          return body;
        }),
      ),
    );
  }

  testWidgets(
      '$PopularMoviesPage should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockBloc.state).thenAnswer((_) => PopularMoviesLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('$PopularMoviesPage should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockBloc.state).thenAnswer((_) => PopularMoviesSuccess([]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('$PopularMoviesPage should display text with message when Error',
      (WidgetTester tester) async {
    when(mockBloc.state).thenAnswer((_) => PopularMoviesError('Error message'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
