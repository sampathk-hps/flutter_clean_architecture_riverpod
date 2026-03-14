import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'collections/job_collection.dart';
import 'collections/job_update_collection.dart';
import 'collections/sync_queue_collection.dart';

class IsarService {
  IsarService._(this.instance);

  final Isar instance;

  IsarCollection<JobCollection> get jobs => instance.jobCollections;
  IsarCollection<JobUpdateCollection> get jobUpdates =>
      instance.jobUpdateCollections;
  IsarCollection<SyncQueueCollection> get syncQueue =>
      instance.syncQueueCollections;

  static Future<IsarService> open() async {
    final directory = await getApplicationDocumentsDirectory();

    final isar = await Isar.open(
      [
        JobCollectionSchema,
        JobUpdateCollectionSchema,
        SyncQueueCollectionSchema,
      ],
      directory: directory.path,
      name: 'field_service_app_db',
      inspector: false,
    );

    return IsarService._(isar);
  }

  Future<void> close() async {
    if (instance.isOpen) {
      await instance.close();
    }
  }
}
