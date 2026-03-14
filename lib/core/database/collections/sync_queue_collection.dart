import 'package:isar_community/isar.dart';

part 'sync_queue_collection.g.dart';

@collection
class SyncQueueCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String queueId;

  @Index()
  late DateTime createdAt;

  DateTime? nextRetryAt;

  late String entityType;
  late String entityId;
  late String operation;
  late String payloadJson;

  int retryCount = 0;
  String? lastError;
}
