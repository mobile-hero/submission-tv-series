import 'package:ditonton/data/models/tv_model.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tv_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class TvResponse extends Equatable {
  final List<TvModel> results;

  TvResponse({required this.results});

  factory TvResponse.fromJson(Map<String, dynamic> json) =>
      _$TvResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TvResponseToJson(this);

  @override
  List<Object> get props => [results];
}