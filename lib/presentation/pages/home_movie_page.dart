import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/bloc/movie/now_playing/now_playing_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/top_rated/top_rated_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/now_playing/now_playing_tvs_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/popular/popular_tvs_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/top_rated/top_rated_tvs_bloc.dart';
import 'package:ditonton/presentation/pages/pages.dart';
import 'package:ditonton/presentation/widgets/horizontal_images.dart';
import 'package:ditonton/presentation/widgets/my_progress_indicator.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/movie.dart';
import '../bloc/movie/popular/popular_movies_bloc.dart';

class HomeMoviePage extends StatefulWidget {
  static const ROUTE_NAME = "/home";

  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage>
    with SingleTickerProviderStateMixin {
  late final tabController = TabController(length: 2, vsync: this);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies & TVs'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              switch (tabController.index) {
                case 0:
                  Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
                  break;
                case 1:
                  Navigator.pushNamed(context, TvSearchPage.ROUTE_NAME);
                  break;
              }
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Column(
        children: [
          TabBar(
            controller: tabController,
            tabs: [
              Tab(
                text: "Movie",
              ),
              Tab(
                text: "TV",
              )
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Now Playing Movie',
                          style: kHeading6,
                        ),
                        HorizontalImagesMovie<NowPlayingMoviesBloc,
                            NowPlayingMoviesEvent, NowPlayingMoviesState>(),
                        SubHeading(
                          title: 'Popular Movie',
                          onTap: () => Navigator.pushNamed(
                              context, PopularMoviesPage.ROUTE_NAME),
                        ),
                        HorizontalImagesMovie<PopularMoviesBloc,
                            PopularMoviesEvent, PopularMoviesState>(),
                        SubHeading(
                          title: 'Top Rated Movie',
                          onTap: () => Navigator.pushNamed(
                              context, TopRatedMoviesPage.ROUTE_NAME),
                        ),
                        HorizontalImagesMovie<TopRatedMoviesBloc,
                            TopRatedMoviesEvent, TopRatedMoviesState>(),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Now Playing TV',
                          style: kHeading6,
                        ),
                        HorizontalImagesTv<NowPlayingTvsBloc,
                            NowPlayingTvsEvent, NowPlayingTvsState>(),
                        SubHeading(
                          title: 'Popular TV',
                          onTap: () => Navigator.pushNamed(
                              context, PopularTvsPage.ROUTE_NAME),
                        ),
                        HorizontalImagesTv<PopularTvsBloc, PopularTvsEvent,
                            PopularTvsState>(),
                        SubHeading(
                          title: 'Top Rated TV',
                          onTap: () => Navigator.pushNamed(
                              context, TopRatedTvsPage.ROUTE_NAME),
                        ),
                        HorizontalImagesTv<TopRatedTvsBloc, TopRatedTvsEvent,
                            TopRatedTvsState>(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SubHeading extends StatelessWidget {
  final String title;
  final Function()? onTap;

  const SubHeading({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () async {
                await FirebaseAnalytics.instance.logEvent(
                  name: "movie_tapped",
                  parameters: {
                    "id": movie.id,
                    "title": movie.title,
                  },
                );
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.ROUTE_NAME,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}

class TvList extends StatelessWidget {
  final List<TvSeries> movies;

  TvList(this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () async {
                await FirebaseAnalytics.instance.logEvent(
                  name: "tv_tapped",
                  parameters: {
                    "id": movie.id,
                    "title": movie.name,
                  },
                );
                Navigator.pushNamed(
                  context,
                  TvDetailPage.ROUTE_NAME,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: movie.posterPath.imageUrl,
                  placeholder: (context, url) => MyProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
