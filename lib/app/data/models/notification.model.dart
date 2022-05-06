class NotificationData {
  int driverId;
  int driverNotificationsId;
  String notificationTypeId;
  String senderName;
  String serviceTicketId;
  String message;
  bool isRead;
  dynamic createdDate;

  NotificationData({
    required this.driverId,
    required this.driverNotificationsId,
    required this.createdDate,
    required this.isRead,
    required this.message,
    required this.notificationTypeId,
    required this.senderName,
    required this.serviceTicketId,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      driverId: json['driverId'],
      driverNotificationsId: json['driverNotificationsId'],
      createdDate: json['createdDate'],
      isRead: json['isRead'],
      message: json['message'],
      notificationTypeId: json['notificationTypeId'],
      senderName: json['senderName'],
      serviceTicketId: json['serviceTicketId'],
    );
  }
}
