import 'package:ditonton/presentation/bloc/movie/top_rated/top_rated_movies_bloc.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_movies_page_test.mocks.dart';

@GenerateMocks([TopRatedMoviesBloc])
void main() {
  late MockTopRatedMoviesBloc mockBloc;

  setUp(() {
    mockBloc = MockTopRatedMoviesBloc();
    when(mockBloc.stream)
        .thenAnswer((_) => Stream.value(TopRatedMoviesInitial()));
  });

  Widget _makeTestableWidget(Widget body) {
    return MaterialApp(
      home: BlocProvider<TopRatedMoviesBloc>.value(
        value: mockBloc,
        child: Builder(builder: (context) {
          return body;
        }),
      ),
    );
  }

  testWidgets('$TopRatedMoviesPage should display progress bar when loading',
      (WidgetTester tester) async {
    when(mockBloc.state).thenAnswer((_) => TopRatedMoviesLoading());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('$TopRatedMoviesPage should display when data is loaded',
      (WidgetTester tester) async {
    when(mockBloc.state).thenAnswer((_) => TopRatedMoviesSuccess([]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('$TopRatedMoviesPage should display text with message when Error',
      (WidgetTester tester) async {
    when(mockBloc.state)
        .thenAnswer((_) => TopRatedMoviesError('Error message'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
