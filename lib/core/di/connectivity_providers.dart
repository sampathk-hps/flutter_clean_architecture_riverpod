import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../connectivity/connectivity_service.dart';
import 'logging_providers.dart';

final connectivityServiceProvider = Provider<ConnectivityService>((ref) {
  final service = ConnectivityService(
    connectivity: Connectivity(),
    logger: ref.watch(appLoggerProvider),
  );

  ref.onDispose(service.dispose);

  return service;
});

final connectivityStatusStreamProvider = StreamProvider<ConnectivityStatus>((
  ref,
) {
  final service = ref.watch(connectivityServiceProvider);
  return service.statusStream;
});
