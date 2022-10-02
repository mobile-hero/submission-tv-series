part of 'tv_detail_bloc.dart';

@immutable
abstract class TvDetailState extends CommonEquatableState {}

class TvDetailInitial extends TvDetailState {}

class TvDetailLoading extends TvDetailState {}

class TvDetailSuccess extends TvDetailState
    implements CommonSuccessState<TvDetailBlocResult> {
  final TvDetailBlocResult source;

  TvDetailSuccess(this.source);

  @override
  List<Object?> get props => [source];
}

class TvDetailError extends TvDetailState implements CommonErrorState {
  final String message;

  TvDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
