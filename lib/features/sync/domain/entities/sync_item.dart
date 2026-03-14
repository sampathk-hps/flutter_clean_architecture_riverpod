class SyncItem {
  const SyncItem({
    required this.id,
    required this.entityType,
    required this.operation,
  });

  final String id;
  final String entityType;
  final String operation;
}
