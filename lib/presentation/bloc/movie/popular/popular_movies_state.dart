part of 'popular_movies_bloc.dart';

@immutable
abstract class PopularMoviesState extends CommonEquatableState {}

class PopularMoviesInitial extends PopularMoviesState {}

class PopularMoviesLoading extends PopularMoviesState
    implements CommonLoadingState {}

class PopularMoviesSuccess extends PopularMoviesState
    implements CommonSuccessState<List<Movie>> {
  final List<Movie> source;

  PopularMoviesSuccess(this.source);

  @override
  List<Object?> get props => [source];
}

class PopularMoviesError extends PopularMoviesState
    implements CommonErrorState {
  final String message;

  PopularMoviesError(this.message);

  @override
  List<Object?> get props => [message];
}
