import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/presentation/bloc/movie/detail/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movie/watchlist/watchlist_movie_manager_bloc.dart';
import 'package:ditonton/presentation/widgets/error_message_container.dart';
import 'package:ditonton/presentation/widgets/my_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../injection.dart';

class MovieDetailProviderPage extends StatelessWidget {
  final int id;

  const MovieDetailProviderPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => locator.get<MovieDetailBloc>()
            ..add(GetMovieDetailEvent(id)),
        ),
        BlocProvider(
          create: (context) => locator.get<WatchlistMovieManagerBloc>()
            ..add(RefreshWatchlistStatus(id)),
        ),
      ],
      child: MovieDetailPage(id: id),
    );
  }
}

class MovieDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail';

  final int id;

  MovieDetailPage({required this.id});

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (context, state) {
          if (state is MovieDetailLoading) {
            return MyProgressIndicator();
          } else if (state is MovieDetailSuccess) {
            return SafeArea(
              child: _DetailContent(
                state.source.detail,
                state.source.recommendations,
              ),
            );
          } else if (state is MovieDetailError) {
            return ErrorMessageContainer(message: state.message);
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}

class _WatchlistButton extends StatelessWidget {
  final MovieDetail movie;

  const _WatchlistButton({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WatchlistMovieManagerBloc, WatchlistMovieManagerState>(
      listener: (context, state) {
        if (state is WatchlistMovieManagerSuccess && state.message != null) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message!)),
          );
        } else if (state is WatchlistMovieManagerError) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(state.message),
              );
            },
          );
        }
      },
      builder: (context, state) {
        return ElevatedButton(
          onPressed: () {
            context
                .read<WatchlistMovieManagerBloc>()
                .add(ToggleWatchlist(movie));
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              context.read<WatchlistMovieManagerBloc>().isAddedToWatchlist
                  ? Icon(Icons.check)
                  : Icon(Icons.add),
              Text('Watchlist'),
            ],
          ),
        );
      },
    );
  }
}

class _RecommendationsSection extends StatelessWidget {
  const _RecommendationsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailBloc, MovieDetailState>(
      builder: (context, state) {
        if (state is MovieDetailLoading) {
          return MyProgressIndicator();
        } else if (state is MovieDetailError) {
          return ErrorMessageContainer(message: state.message);
        } else if (state is MovieDetailSuccess) {
          final recommendations = state.source.recommendations;
          return Container(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final movie = recommendations[index];
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                        context,
                        MovieDetailPage.ROUTE_NAME,
                        arguments: movie.id,
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: movie.posterPath?.imageUrl ?? "-",
                        placeholder: (context, url) => MyProgressIndicator(),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                );
              },
              itemCount: recommendations.length,
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class _DetailContent extends StatelessWidget {
  final MovieDetail movie;
  final List<Movie> recommendations;

  _DetailContent(this.movie, this.recommendations);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: movie.posterPath.imageUrl,
          width: screenWidth,
          placeholder: (context, url) => MyProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.title,
                              style: kHeading5,
                            ),
                            _WatchlistButton(movie: movie),
                            Text(movie.genres.names),
                            Text(movie.runtime.convertToReadableDuration),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: movie.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${movie.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              movie.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            _RecommendationsSection(),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }
}
