import 'package:isar_community/isar.dart';

part 'job_update_collection.g.dart';

@collection
class JobUpdateCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String updateId;

  @Index()
  late String jobId;

  String? notes;
  String? status;
  String? imagePath;

  late DateTime createdAt;

  bool isSynced = false;
  int retryCount = 0;
}
