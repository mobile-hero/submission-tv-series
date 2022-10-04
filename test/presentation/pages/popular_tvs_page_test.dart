import 'package:ditonton/presentation/bloc/tv/popular/popular_tvs_bloc.dart';
import 'package:ditonton/presentation/pages/popular_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_tvs_page_test.mocks.dart';

@GenerateMocks([PopularTvsBloc])
void main() {
  late MockPopularTvsBloc mockBloc;

  setUp(() {
    mockBloc = MockPopularTvsBloc();
    when(mockBloc.stream).thenAnswer((_) => Stream.value(PopularTvsInitial()));
  });

  Widget _makeTestableWidget(Widget body) {
    return MaterialApp(
      home: BlocProvider<PopularTvsBloc>.value(
        value: mockBloc,
        child: Builder(builder: (context) {
          return body;
        }),
      ),
    );
  }

  testWidgets('$PopularTvsPage should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockBloc.state).thenAnswer((_) => PopularTvsLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularTvsPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('$PopularTvsPage should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockBloc.state).thenAnswer((_) => PopularTvsSuccess([]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularTvsPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('$PopularTvsPage should display text with message when Error',
      (WidgetTester tester) async {
    when(mockBloc.state).thenAnswer((_) => PopularTvsError('Error message'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularTvsPage()));

    expect(textFinder, findsOneWidget);
  });
}
