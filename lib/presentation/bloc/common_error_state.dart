import 'package:equatable/equatable.dart';

abstract class CommonErrorState {
  final String message;

  CommonErrorState(this.message);
}
