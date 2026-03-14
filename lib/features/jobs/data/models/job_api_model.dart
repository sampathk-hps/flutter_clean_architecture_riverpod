import 'package:json_annotation/json_annotation.dart';

part 'job_api_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class JobApiModel {
  const JobApiModel({
    required this.id,
    required this.title,
    required this.status,
    required this.updatedAt,
    this.description,
    this.scheduledAt,
    this.imagePaths = const [],
  });

  factory JobApiModel.fromJson(Map<String, dynamic> json) =>
      _$JobApiModelFromJson(json);

  final String id;
  final String title;
  final String? description;
  final String status;
  final DateTime? scheduledAt;
  final DateTime updatedAt;
  final List<String> imagePaths;

  Map<String, dynamic> toJson() => _$JobApiModelToJson(this);
}
