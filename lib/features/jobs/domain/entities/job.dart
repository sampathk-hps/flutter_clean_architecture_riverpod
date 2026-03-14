class Job {
  const Job({
    required this.id,
    required this.title,
    required this.status,
    required this.updatedAt,
    this.description,
    this.scheduledAt,
    this.imagePaths = const [],
    this.isSynced = false,
  });

  final String id;
  final String title;
  final String? description;
  final String status;
  final DateTime? scheduledAt;
  final DateTime updatedAt;
  final List<String> imagePaths;
  final bool isSynced;

  Job copyWith({
    String? id,
    String? title,
    String? description,
    String? status,
    DateTime? scheduledAt,
    DateTime? updatedAt,
    List<String>? imagePaths,
    bool? isSynced,
  }) {
    return Job(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      updatedAt: updatedAt ?? this.updatedAt,
      imagePaths: imagePaths ?? this.imagePaths,
      isSynced: isSynced ?? this.isSynced,
    );
  }
}
