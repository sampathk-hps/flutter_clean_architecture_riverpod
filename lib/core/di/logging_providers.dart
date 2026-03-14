import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../logger/app_logger.dart';

final appLoggerProvider = Provider<AppLogger>((ref) => AppLogger());
