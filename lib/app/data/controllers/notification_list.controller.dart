import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/data/interfaces/interfaces.dart';
import 'package:driver_app/app/data/models/models.dart';
import 'package:driver_app/app/data/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationListController extends GetxController {
  List<NotificationModel> notifications = <NotificationModel>[].obs;

  RxBool loading = false.obs;

  final INotification notificationService = NotificationService();

  @override
  void onInit() {
    getNotificationList();
    super.onInit();
  }

  getNotificationList() {
    setLoading();
    notificationService
        .getNotifications(
            driverId: Get.find<DriverController>().driver.value.driverId)
        .then(
      (value) {
        setLoading();
        setNotification(value);
      },
    ).catchError(
      (error) {
        setLoading();
        Get.snackbar(
          'error_snackbar_title'.tr,
          error.toString(),
          backgroundColor: Colors.red[400],
          colorText: Colors.white,
          duration: const Duration(
            seconds: 4,
          ),
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(15),
        );
      },
    );
  }

  updateNotification(index, driverNotificationsId) {
    notificationService
        .updateNotification(
      driverNotificationId: driverNotificationsId,
      isRead: true,
    )
        .then(
      (value) {
        updateNotificationStatus(index, value);
      },
    ).catchError(
      (error) {
        setLoading();
        Get.snackbar(
          'error_snackbar_title'.tr,
          error.toString(),
          backgroundColor: Colors.red[400],
          colorText: Colors.white,
          duration: const Duration(
            seconds: 4,
          ),
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(15),
        );
      },
    );
  }

  void setLoading() {
    loading.toggle();
    update();
  }

  setNotification(List<NotificationModel> value) {
    notifications = value;
    update();
  }

  /// Update Notification
  void updateNotificationStatus(index, NotificationModel notification) {
    notifications[index] = notification;
    update();
  }
}
