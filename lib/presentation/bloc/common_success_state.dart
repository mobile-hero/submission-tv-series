import 'package:equatable/equatable.dart';

abstract class CommonSuccessState<T> {
  final T source;

  CommonSuccessState(this.source);
}