abstract class INotification {
  Future<dynamic> getNotifications({
    required driverId,
  });

  Future<dynamic> updateNotification({
    required int driverNotificationId,
    required bool isRead,
  });
}
