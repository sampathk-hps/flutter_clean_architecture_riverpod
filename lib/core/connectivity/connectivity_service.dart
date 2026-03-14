import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

import '../logger/app_logger.dart';

enum ConnectivityStatus { online, offline }

class ConnectivityService {
  ConnectivityService({
    required Connectivity connectivity,
    required AppLogger logger,
  }) : _connectivity = connectivity,
       _logger = logger;

  final Connectivity _connectivity;
  final AppLogger _logger;

  final StreamController<ConnectivityStatus> _statusController =
      StreamController<ConnectivityStatus>.broadcast();

  StreamSubscription<dynamic>? _subscription;
  ConnectivityStatus _currentStatus = ConnectivityStatus.offline;

  Stream<ConnectivityStatus> get statusStream => _statusController.stream;
  ConnectivityStatus get currentStatus => _currentStatus;
  bool get isOnline => _currentStatus == ConnectivityStatus.online;

  Future<void> initialize() async {
    final initial = await _connectivity.checkConnectivity();
    _emitStatusFromRaw(initial);

    _subscription ??= _connectivity.onConnectivityChanged.listen(
      _emitStatusFromRaw,
    );
  }

  void _emitStatusFromRaw(dynamic raw) {
    final results = raw is List<ConnectivityResult>
        ? raw
        : <ConnectivityResult>[raw as ConnectivityResult];

    final online = results.any((result) => result != ConnectivityResult.none);
    final nextStatus = online
        ? ConnectivityStatus.online
        : ConnectivityStatus.offline;

    if (nextStatus != _currentStatus) {
      _logger.i('Connectivity changed: $nextStatus');
      _currentStatus = nextStatus;
      _statusController.add(nextStatus);
    }
  }

  void dispose() {
    _subscription?.cancel();
    _subscription = null;
    _statusController.close();
  }
}
