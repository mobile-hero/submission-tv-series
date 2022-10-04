part of 'search_movies_bloc.dart';

@immutable
abstract class SearchMoviesEvent {}

class SearchMoviesNow extends SearchMoviesEvent {
  final String keyword;

  SearchMoviesNow(this.keyword);
}