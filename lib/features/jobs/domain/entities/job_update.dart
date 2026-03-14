class JobUpdate {
  const JobUpdate({
    required this.updateId,
    required this.jobId,
    required this.createdAt,
    this.notes,
    this.status,
    this.imagePath,
  });

  final String updateId;
  final String jobId;
  final String? notes;
  final String? status;
  final String? imagePath;
  final DateTime createdAt;
}
