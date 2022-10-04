part of 'movie_detail_bloc.dart';

@immutable
abstract class MovieDetailEvent {}

class GetMovieDetailEvent extends MovieDetailEvent {
  final int id;

  GetMovieDetailEvent(this.id);
}