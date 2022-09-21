import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

class Creator extends Equatable {
  final int id;
  final String creditId;
  final String name;
  final String? profilePath;

  Creator({
    required this.id,
    required this.creditId,
    required this.name,
    required this.profilePath,
  });

  @override
  List<Object?> get props => [
    id,
    creditId,
    name,
    profilePath,
  ];
}
