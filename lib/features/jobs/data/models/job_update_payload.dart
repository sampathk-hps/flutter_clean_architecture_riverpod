import 'package:json_annotation/json_annotation.dart';

part 'job_update_payload.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class JobUpdatePayload {
  const JobUpdatePayload({
    required this.updateId,
    required this.jobId,
    required this.createdAt,
    this.notes,
    this.status,
    this.imagePath,
  });

  factory JobUpdatePayload.fromJson(Map<String, dynamic> json) =>
      _$JobUpdatePayloadFromJson(json);

  final String updateId;
  final String jobId;
  final String? notes;
  final String? status;
  final String? imagePath;
  final DateTime createdAt;

  Map<String, dynamic> toJson() => _$JobUpdatePayloadToJson(this);
}
