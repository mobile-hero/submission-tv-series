part of 'search_tvs_bloc.dart';

@immutable
abstract class SearchTvsEvent {}

class SearchTvsNow extends SearchTvsEvent {
  final String keyword;

  SearchTvsNow(this.keyword);
}