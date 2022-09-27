import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/pages/pages.dart';
import 'package:ditonton/presentation/provider/tv_list_notifier.dart';
import 'package:ditonton/presentation/widgets/my_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/movie.dart';
import '../provider/movie_list_notifier.dart';

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
    Future.microtask(() {
      Provider.of<MovieListNotifier>(context, listen: false)
        ..fetchNowPlayingMovies()
        ..fetchPopularMovies()
        ..fetchTopRatedMovies();
      Provider.of<TvListNotifier>(context, listen: false)
        ..fetchNowPlayingTvs()
        ..fetchPopularTvs()
        ..fetchTopRatedTvs();
    });
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
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist TV'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistTvsPage.ROUTE_NAME);
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
                        Consumer<MovieListNotifier>(
                            builder: (context, data, child) {
                          final state = data.nowPlayingState;
                          if (state == RequestState.Loading) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state == RequestState.Loaded) {
                            return MovieList(data.nowPlayingMovies);
                          } else {
                            return Text('Failed');
                          }
                        }),
                        _buildSubHeading(
                          title: 'Popular Movie',
                          onTap: () => Navigator.pushNamed(
                              context, PopularMoviesPage.ROUTE_NAME),
                        ),
                        Consumer<MovieListNotifier>(
                            builder: (context, data, child) {
                          final state = data.popularMoviesState;
                          if (state == RequestState.Loading) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state == RequestState.Loaded) {
                            return MovieList(data.popularMovies);
                          } else {
                            return Text('Failed');
                          }
                        }),
                        _buildSubHeading(
                          title: 'Top Rated Movie',
                          onTap: () => Navigator.pushNamed(
                              context, TopRatedMoviesPage.ROUTE_NAME),
                        ),
                        Consumer<MovieListNotifier>(
                            builder: (context, data, child) {
                          final state = data.topRatedMoviesState;
                          if (state == RequestState.Loading) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state == RequestState.Loaded) {
                            return MovieList(data.topRatedMovies);
                          } else {
                            return Text('Failed');
                          }
                        }),
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
                        Consumer<TvListNotifier>(builder: (context, data, child) {
                          final state = data.nowPlayingState;
                          if (state == RequestState.Loading) {
                            return MyProgressIndicator();
                          } else if (state == RequestState.Loaded) {
                            return TvList(data.nowPlayingTvs);
                          } else {
                            return Text('Failed');
                          }
                        }),
                        _buildSubHeading(
                          title: 'Popular TV',
                          onTap: () => Navigator.pushNamed(
                              context, PopularTvsPage.ROUTE_NAME),
                        ),
                        Consumer<TvListNotifier>(builder: (context, data, child) {
                          final state = data.popularTvsState;
                          if (state == RequestState.Loading) {
                            return MyProgressIndicator();
                          } else if (state == RequestState.Loaded) {
                            return TvList(data.popularTvs);
                          } else {
                            return Text('Failed');
                          }
                        }),
                        _buildSubHeading(
                          title: 'Top Rated TV',
                          onTap: () => Navigator.pushNamed(
                              context, TopRatedTvsPage.ROUTE_NAME),
                        ),
                        Consumer<TvListNotifier>(builder: (context, data, child) {
                          final state = data.topRatedTvsState;
                          if (state == RequestState.Loading) {
                            return MyProgressIndicator();
                          } else if (state == RequestState.Loaded) {
                            return TvList(data.topRatedTvs);
                          } else {
                            return Text('Failed');
                          }
                        }),
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

  Row _buildSubHeading({required String title, required Function() onTap}) {
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
              onTap: () {
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
              onTap: () {
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
