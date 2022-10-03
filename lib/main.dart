import 'dart:async';

import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/firebase_options.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:ditonton/presentation/bloc/movie/watchlist/watchlist_movie_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/bloc/movie/now_playing/now_playing_movies_bloc.dart';
import 'presentation/bloc/movie/popular/popular_movies_bloc.dart';
import 'presentation/bloc/movie/top_rated/top_rated_movies_bloc.dart';
import 'presentation/bloc/tv/now_playing/now_playing_tvs_bloc.dart';
import 'presentation/bloc/tv/popular/popular_tvs_bloc.dart';
import 'presentation/bloc/tv/top_rated/top_rated_tvs_bloc.dart';
import 'presentation/pages/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runZonedGuarded<Future<void>>(() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

    runApp(MyApp());
  },
      (error, stack) =>
          FirebaseCrashlytics.instance.recordError(error, stack, fatal: true));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
          di.locator<NowPlayingMoviesBloc>()..add(GetNowPlayingEvent()),
        ),
        BlocProvider(
          create: (context) =>
          di.locator<PopularMoviesBloc>()..add(GetPopularMoviesEvent()),
        ),
        BlocProvider(
          create: (context) =>
          di.locator<TopRatedMoviesBloc>()..add(GetTopRatedMoviesEvent()),
        ),
        BlocProvider(
          create: (context) =>
          di.locator<NowPlayingTvsBloc>()..add(GetNowPlayingTvsEvent()),
        ),
        BlocProvider(
          create: (context) =>
          di.locator<PopularTvsBloc>()..add(GetPopularTvsEvent()),
        ),
        BlocProvider(
          create: (context) =>
          di.locator<TopRatedTvsBloc>()..add(GetTopRatedTvsEvent()),
        ),
        BlocProvider(
          create: (context) =>
          di.locator<WatchlistMovieBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HomeMoviePage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case PopularTvsPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularTvsPage());
            case TopRatedTvsPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedTvsPage());
            case TvDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvDetailPage(id: id),
                settings: settings,
              );
            case TvEpisodesPage.ROUTE_NAME:
              final map = settings.arguments as Map<String, dynamic>;
              final movieId = map['id'];
              final seasonNumber = map['seasonNumber'];
              final seasonName = map['seasonName'];
              return MaterialPageRoute(
                builder: (_) => TvEpisodesPage(
                    movieId: movieId,
                    seasonNumber: seasonNumber,
                    seasonName: seasonName),
                settings: settings,
              );
            case TvSearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TvSearchPage());
            case WatchlistTvsPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistTvsPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
