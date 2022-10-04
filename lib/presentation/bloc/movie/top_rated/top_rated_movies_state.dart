part of 'top_rated_movies_bloc.dart';

@immutable
abstract class TopRatedMoviesState extends CommonEquatableState {}

class TopRatedMoviesInitial extends TopRatedMoviesState {}

class TopRatedMoviesLoading extends TopRatedMoviesState {}

class TopRatedMoviesSuccess extends TopRatedMoviesState
    implements CommonSuccessState<List<Movie>> {
  final List<Movie> source;

  TopRatedMoviesSuccess(this.source);

  @override
  List<Object?> get props => [source];
}

class TopRatedMoviesError extends TopRatedMoviesState
    implements CommonErrorState {
  final String message;

  TopRatedMoviesError(this.message);

  @override
  List<Object?> get props => [message];
}
