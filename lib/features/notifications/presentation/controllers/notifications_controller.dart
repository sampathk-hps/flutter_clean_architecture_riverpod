import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../di/notifications_providers.dart';
import '../../domain/entities/app_notification.dart';

final notificationsControllerProvider =
    AsyncNotifierProvider<NotificationsController, List<AppNotification>>(
      NotificationsController.new,
    );

class NotificationsController extends AsyncNotifier<List<AppNotification>> {
  @override
  Future<List<AppNotification>> build() async {
    return ref.read(notificationsRepositoryProvider).getNotifications();
  }
}
