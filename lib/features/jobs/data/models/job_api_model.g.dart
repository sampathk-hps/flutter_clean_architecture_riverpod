// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobApiModel _$JobApiModelFromJson(Map<String, dynamic> json) => JobApiModel(
  id: json['id'] as String,
  title: json['title'] as String,
  status: json['status'] as String,
  updatedAt: DateTime.parse(json['updated_at'] as String),
  description: json['description'] as String?,
  scheduledAt: json['scheduled_at'] == null
      ? null
      : DateTime.parse(json['scheduled_at'] as String),
  imagePaths:
      (json['image_paths'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$JobApiModelToJson(JobApiModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'status': instance.status,
      'scheduled_at': instance.scheduledAt?.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'image_paths': instance.imagePaths,
    };
