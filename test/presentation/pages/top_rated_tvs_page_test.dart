import 'package:ditonton/presentation/bloc/tv/top_rated/top_rated_tvs_bloc.dart';
import 'package:ditonton/presentation/pages/top_rated_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_tvs_page_test.mocks.dart';

@GenerateMocks([TopRatedTvsBloc])
void main() {
  late MockTopRatedTvsBloc mockBloc;

  setUp(() {
    mockBloc = MockTopRatedTvsBloc();
    when(mockBloc.stream).thenAnswer((_) => Stream.value(TopRatedTvsInitial()));
  });

  Widget _makeTestableWidget(Widget body) {
    return MaterialApp(
      home: BlocProvider<TopRatedTvsBloc>.value(
        value: mockBloc,
        child: Builder(builder: (context) {
          return body;
        }),
      ),
    );
  }

  testWidgets('$TopRatedTvsPage should display progress bar when loading',
      (WidgetTester tester) async {
    when(mockBloc.state).thenAnswer((_) => TopRatedTvsLoading());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvsPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('$TopRatedTvsPage should display when data is loaded',
      (WidgetTester tester) async {
    when(mockBloc.state).thenAnswer((_) => TopRatedTvsSuccess([]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvsPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('$TopRatedTvsPage should display text with message when Error',
      (WidgetTester tester) async {
    when(mockBloc.state).thenAnswer((_) => TopRatedTvsError('Error message'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvsPage()));

    expect(textFinder, findsOneWidget);
  });
}
