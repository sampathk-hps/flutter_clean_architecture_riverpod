import '../../../../core/database/collections/job_collection.dart';
import '../../../../core/database/collections/job_update_collection.dart';
import '../../domain/entities/job.dart';
import '../../domain/entities/job_update.dart';
import 'job_api_model.dart';
import 'job_update_payload.dart';

extension JobApiModelMapper on JobApiModel {
  Job toEntity() {
    return Job(
      id: id,
      title: title,
      description: description,
      status: status,
      scheduledAt: scheduledAt,
      updatedAt: updatedAt,
      imagePaths: imagePaths,
      isSynced: true,
    );
  }

  JobCollection toCollection() {
    return JobCollection()
      ..jobId = id
      ..title = title
      ..description = description
      ..status = status
      ..scheduledAt = scheduledAt
      ..updatedAt = updatedAt
      ..isSynced = true
      ..imagePaths = imagePaths;
  }
}

extension JobCollectionMapper on JobCollection {
  Job toEntity() {
    return Job(
      id: jobId,
      title: title,
      description: description,
      status: status,
      scheduledAt: scheduledAt,
      updatedAt: updatedAt,
      imagePaths: imagePaths,
      isSynced: isSynced,
    );
  }
}

extension JobUpdateMapper on JobUpdate {
  JobUpdateCollection toCollection({required bool isSynced}) {
    return JobUpdateCollection()
      ..updateId = updateId
      ..jobId = jobId
      ..notes = notes
      ..status = status
      ..imagePath = imagePath
      ..createdAt = createdAt
      ..isSynced = isSynced;
  }

  JobUpdatePayload toPayload() {
    return JobUpdatePayload(
      updateId: updateId,
      jobId: jobId,
      notes: notes,
      status: status,
      imagePath: imagePath,
      createdAt: createdAt,
    );
  }
}
