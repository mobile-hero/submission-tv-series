import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/widgets/season_horizontal_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../injection.dart';
import '../bloc/tv/detail/tv_detail_bloc.dart';
import '../bloc/tv/watchlist/watchlist_tv_manager_bloc.dart';
import '../widgets/error_message_container.dart';
import '../widgets/my_progress_indicator.dart';
import 'tv_episodes_page.dart';

class TvDetailProviderPage extends StatelessWidget {
  final int id;

  const TvDetailProviderPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              locator.get<TvDetailBloc>()..add(GetTvDetailEvent(id)),
        ),
        BlocProvider(
          create: (context) => locator.get<WatchlistTvManagerBloc>()
            ..add(RefreshWatchlistStatus(id)),
        ),
      ],
      child: TvDetailPage(id: id),
    );
  }
}

class TvDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-tv';

  final int id;

  TvDetailPage({required this.id});

  @override
  _TvDetailPageState createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvDetailPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TvDetailBloc, TvDetailState>(
        builder: (context, state) {
          if (state is TvDetailLoading) {
            return MyProgressIndicator();
          } else if (state is TvDetailSuccess) {
            return SafeArea(
              child: _DetailContent(
                state.source.detail,
                state.source.recommendations,
              ),
            );
          } else if (state is TvDetailError) {
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
  final TvDetail movie;

  const _WatchlistButton({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WatchlistTvManagerBloc, WatchlistTvManagerState>(
      listener: (context, state) {
        if (state is WatchlistTvManagerSuccess && state.message != null) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message!)),
          );
        } else if (state is WatchlistTvManagerError) {
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
            context.read<WatchlistTvManagerBloc>().add(ToggleWatchlist(movie));
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              context.read<WatchlistTvManagerBloc>().isAddedToWatchlist
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
    return BlocBuilder<TvDetailBloc, TvDetailState>(
      builder: (context, state) {
        if (state is TvDetailLoading) {
          return MyProgressIndicator();
        } else if (state is TvDetailError) {
          return ErrorMessageContainer(message: state.message);
        } else if (state is TvDetailSuccess) {
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
                        TvDetailPage.ROUTE_NAME,
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
  final TvDetail movie;
  final List<TvSeries> recommendations;

  _DetailContent(
    this.movie,
    this.recommendations,
  );

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
                              movie.name,
                              style: kHeading5,
                            ),
                            _WatchlistButton(movie: movie),
                            const SizedBox(height: 8),
                            Text(movie.genres.names),
                            Text(
                              (movie.episodeRunTime.isNotEmpty
                                      ? movie.episodeRunTime.first
                                      : 0)
                                  .convertToReadableDuration,
                            ),
                            const SizedBox(height: 16),
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
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              movie.overview,
                            ),
                            const SizedBox(height: 16),
                            SeasonHorizontalList(
                              seasons: movie.seasons,
                              onTap: (int seasonNumber, String seasonName) {
                                Navigator.pushNamed(
                                  context,
                                  TvEpisodesPage.ROUTE_NAME,
                                  arguments: {
                                    "id": movie.id,
                                    "seasonNumber": seasonNumber,
                                    "seasonName": seasonName,
                                  },
                                );
                              },
                            ),
                            const SizedBox(height: 16),
                            _RecommendationsSection(),
                            const SizedBox(height: 36),
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
