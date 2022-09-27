import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/watchlist_movie_notifier.dart';
import '../provider/watchlist_tv_notifier.dart';
import '../widgets/tv_card_list.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware, SingleTickerProviderStateMixin {
  late final tabController = TabController(length: 2, vsync: this);

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<WatchlistMovieNotifier>(context, listen: false)
          .fetchWatchlistMovies();
      Provider.of<WatchlistTvNotifier>(context, listen: false)
          .fetchWatchlistTvs();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    Provider.of<WatchlistMovieNotifier>(context, listen: false)
        .fetchWatchlistMovies();
    Provider.of<WatchlistTvNotifier>(context, listen: false)
        .fetchWatchlistTvs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
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
                  child: Consumer<WatchlistMovieNotifier>(
                    builder: (context, data, child) {
                      if (data.watchlistState == RequestState.Loading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (data.watchlistState == RequestState.Loaded) {
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            final movie = data.watchlistMovies[index];
                            return MovieCard(movie);
                          },
                          itemCount: data.watchlistMovies.length,
                        );
                      } else {
                        return Center(
                          key: Key('error_message'),
                          child: Text(data.message),
                        );
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Consumer<WatchlistTvNotifier>(
                    builder: (context, data, child) {
                      if (data.watchlistState == RequestState.Loading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (data.watchlistState == RequestState.Loaded) {
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            final movie = data.watchlistTvs[index];
                            return TvCard(movie);
                          },
                          itemCount: data.watchlistTvs.length,
                        );
                      } else {
                        return Center(
                          key: Key('error_message'),
                          child: Text(data.message),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
