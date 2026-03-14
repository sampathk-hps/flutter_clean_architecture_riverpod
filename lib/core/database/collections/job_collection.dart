import 'package:isar_community/isar.dart';

part 'job_collection.g.dart';

@collection
class JobCollection {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String jobId;

  late String title;
  String? description;

  @Index()
  late String status;

  DateTime? scheduledAt;

  @Index()
  late DateTime updatedAt;

  bool isSynced = false;

  List<String> imagePaths = [];
}
