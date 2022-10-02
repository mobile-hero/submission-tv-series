part of 'tv_detail_bloc.dart';

@immutable
abstract class TvDetailState {}

class TvDetailInitial extends TvDetailState {}

class TvDetailLoading extends TvDetailState {}

class TvDetailSuccess extends CommonSuccessState<TvDetailBlocResult>
    with TvDetailState {
  TvDetailSuccess(TvDetailBlocResult source) : super(source);
}

class TvDetailError extends CommonErrorState with TvDetailState {
  TvDetailError(String message) : super(message);
}
