// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_update_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobUpdatePayload _$JobUpdatePayloadFromJson(Map<String, dynamic> json) =>
    JobUpdatePayload(
      updateId: json['update_id'] as String,
      jobId: json['job_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      notes: json['notes'] as String?,
      status: json['status'] as String?,
      imagePath: json['image_path'] as String?,
    );

Map<String, dynamic> _$JobUpdatePayloadToJson(JobUpdatePayload instance) =>
    <String, dynamic>{
      'update_id': instance.updateId,
      'job_id': instance.jobId,
      'notes': instance.notes,
      'status': instance.status,
      'image_path': instance.imagePath,
      'created_at': instance.createdAt.toIso8601String(),
    };
