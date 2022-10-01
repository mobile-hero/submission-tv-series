part of 'popular_tvs_bloc.dart';

@immutable
abstract class PopularTvsState {}

class PopularTvsInitial extends PopularTvsState {}

class PopularTvsLoading extends PopularTvsState {}

class PopularTvsSuccess extends PopularTvsState {}

class PopularTvsError extends CommonErrorState with PopularTvsState {
  PopularTvsError(String message) : super(message);
}
