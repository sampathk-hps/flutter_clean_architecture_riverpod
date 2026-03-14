import '../../domain/entities/app_notification.dart';
import '../../domain/repositories/notifications_repository.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  @override
  Future<List<AppNotification>> getNotifications() async {
    return const <AppNotification>[];
  }
}
