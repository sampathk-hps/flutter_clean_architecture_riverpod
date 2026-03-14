import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../database/isar_service.dart';
import '../storage/secure_storage_service.dart';

final secureStorageProvider = Provider<SecureStorageService>((ref) {
  return SecureStorageService(const FlutterSecureStorage());
});

final isarServiceProvider = Provider<IsarService>((ref) {
  throw UnimplementedError(
    'isarServiceProvider must be overridden in main.dart',
  );
});
