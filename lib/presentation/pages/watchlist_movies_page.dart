import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/movie/watchlist/watchlist_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/tv/watchlist/watchlist_tv_bloc.dart';
import 'package:ditonton/presentation/widgets/error_message_container.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:ditonton/presentation/widgets/my_progress_indicator.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      context.read<WatchlistMovieBloc>().add(GetWatchlistMovieEvent());
      context.read<WatchlistTvBloc>().add(GetWatchlistTvEvent());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<WatchlistMovieBloc>().add(GetWatchlistMovieEvent());
    context.read<WatchlistTvBloc>().add(GetWatchlistTvEvent());
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
                  child: BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
                    builder: (context, state) {
                      if (state is WatchlistMovieLoading) {
                        return MyProgressIndicator();
                      } else if (state is WatchlistMovieSuccess) {
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            final movie = state.source[index];
                            return MovieCard(movie);
                          },
                          itemCount: state.source.length,
                        );
                      } else if (state is WatchlistMovieError) {
                        return ErrorMessageContainer(message: state.message);
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BlocBuilder<WatchlistTvBloc, WatchlistTvState>(
                    builder: (context, state) {
                      if (state is WatchlistTvLoading) {
                        return MyProgressIndicator();
                      } else if (state is WatchlistTvSuccess) {
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            final movie = state.source[index];
                            return TvCard(movie);
                          },
                          itemCount: state.source.length,
                        );
                      } else if (state is WatchlistTvError) {
                        return ErrorMessageContainer(message: state.message);
                      } else {
                        return SizedBox.shrink();
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
