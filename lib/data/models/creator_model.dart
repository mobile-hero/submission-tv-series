import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/creator.dart';

part 'creator_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CreatorModel extends Equatable {
  final int id;
  final String creditId;
  final String name;
  final String? profilePath;

  CreatorModel({
    required this.id,
    required this.creditId,
    required this.name,
    required this.profilePath,
  });

  factory CreatorModel.fromJson(Map<String, dynamic> json) =>
      _$CreatorModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreatorModelToJson(this);

  Creator toEntity() => Creator(
        id: this.id,
        creditId: this.creditId,
        name: this.name,
        profilePath: this.profilePath,
      );

  @override
  List<Object?> get props => [
        id,
        creditId,
        name,
        profilePath,
      ];
}
