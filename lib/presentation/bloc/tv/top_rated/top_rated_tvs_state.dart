part of 'top_rated_tvs_bloc.dart';

@immutable
abstract class TopRatedTvsState {}

class TopRatedTvsInitial extends TopRatedTvsState {}

class TopRatedTvsLoading extends TopRatedTvsState {}

class TopRatedTvsSuccess extends TopRatedTvsState {}

class TopRatedTvsError extends CommonErrorState with TopRatedTvsState {
  TopRatedTvsError(String message) : super(message);
}
