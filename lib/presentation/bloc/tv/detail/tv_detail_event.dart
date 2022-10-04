part of 'tv_detail_bloc.dart';

@immutable
abstract class TvDetailEvent {}

class GetTvDetailEvent extends TvDetailEvent {
  final int id;

  GetTvDetailEvent(this.id);
}
