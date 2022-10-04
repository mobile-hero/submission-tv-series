part of 'search_movies_bloc.dart';

@immutable
abstract class SearchMoviesState extends CommonEquatableState {}

class SearchMoviesInitial extends SearchMoviesState {}

class SearchMoviesLoading extends SearchMoviesState {}

class SearchMoviesSuccess extends SearchMoviesState
    implements CommonSuccessState<List<Movie>> {
  final List<Movie> source;

  SearchMoviesSuccess(this.source);

  @override
  List<Object?> get props => [source];
}

class SearchMoviesError extends SearchMoviesState implements CommonErrorState {
  final String message;

  SearchMoviesError(this.message);

  @override
  List<Object?> get props => [message];
}
