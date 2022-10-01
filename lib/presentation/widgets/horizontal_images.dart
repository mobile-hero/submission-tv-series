import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/bloc/common_loading_state.dart';
import 'package:ditonton/presentation/bloc/common_success_state.dart';
import 'package:ditonton/presentation/widgets/error_message_container.dart';
import 'package:ditonton/presentation/widgets/my_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/movie.dart';
import '../bloc/common_error_state.dart';
import '../pages/home_movie_page.dart';

class HorizontalImagesMovie<B extends Bloc<E, S>, E extends Object,
    S extends Object> extends StatelessWidget {
  const HorizontalImagesMovie({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, S>(
      builder: (context, state) {
        if (state is CommonLoadingState) {
          return MyProgressIndicator();
        } else if (state is CommonSuccessState<List<Movie>>) {
          return MovieList(state.source);
        } else if (state is CommonErrorState) {
          return ErrorMessageContainer(message: 'Failed');
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}

class HorizontalImagesTv<B extends Bloc<E, S>, E extends Object,
    S extends Object> extends StatelessWidget {
  const HorizontalImagesTv({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<B, S>(
      builder: (context, state) {
        if (state is CommonLoadingState) {
          return MyProgressIndicator();
        } else if (state is CommonSuccessState<List<TvSeries>>) {
          return TvList(state.source);
        } else if (state is CommonErrorState) {
          return ErrorMessageContainer(message: 'Failed');
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
