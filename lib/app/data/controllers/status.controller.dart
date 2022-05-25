import 'dart:async';

import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/data/interfaces/interfaces.dart';
import 'package:driver_app/app/data/models/models.dart';
import 'package:driver_app/app/data/services/services.dart';
import 'package:driver_app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatusController extends GetxController {
  final onlineStatus = Status().obs;

  static Timer? toastTimer;

  final currentStatus = false.obs;

  final IStatus _statusService = StatusService();

  /// Sets Value of Online Status
  void setOnlineStatus({bool? isOnline, Widget? child}) {
    onlineStatus.value.isOnline = isOnline!;
    onlineStatus.value.isDisplayed = true;
    onlineStatus.value.child = child!;
    update();

    if (toastTimer != null && toastTimer!.isActive) {
      toastTimer!.cancel();
    }

    toastTimer = Timer(const Duration(seconds: 5), () {
      onlineStatus.value.isDisplayed = false;
      update();
    });
  }

  /// Inverts Current Status
  void toggleCurrentStatus({
    required VoidCallback callback,
  }) {
    currentStatus.toggle();

    String message =
        currentStatus.value ? 'You are now Online!' : 'You are now Offline!';

    Get.dialog(
      const ModalLoader(),
      barrierDismissible: false,
    );

    _statusService
        .updateDriverOnlineStatus(
      driverId: Get.find<DriverController>().driver.value.driverId,
      onlineStatus: currentStatus.value,
      latestLat: Get.find<LocationController>().currentLoc.value.latitude,
      latestLng: Get.find<LocationController>().currentLoc.value.longitude,
    )
        .then((result) {
      Get.back();

      Widget widget = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!currentStatus.value)
            const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.warning,
                color: Colors.white,
                size: 17,
              ),
            ),
          Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      );

      setOnlineStatus(
        isOnline: currentStatus.value,
        child: widget,
      );

      callback();
    }).catchError((e) {
      Get.back();
      currentStatus.toggle();
    });
  }

  void toggleCurrentStatusFleetSelection({
    required VoidCallback callback,
  }) {
    currentStatus.value = true;

    String message = 'You are now Online!';

    Get.dialog(
      const ModalLoader(),
      barrierDismissible: false,
    );

    _statusService
        .updateDriverOnlineStatus(
      driverId: Get.find<DriverController>().driver.value.driverId,
      onlineStatus: currentStatus.value,
      latestLat: Get.find<LocationController>().currentLoc.value.latitude,
      latestLng: Get.find<LocationController>().currentLoc.value.longitude,
    )
        .then((result) {
      Get.back();

      Widget widget = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!currentStatus.value)
            const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.warning,
                color: Colors.white,
                size: 17,
              ),
            ),
          Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      );

      setOnlineStatus(
        isOnline: currentStatus.value,
        child: widget,
      );

      callback();
    }).catchError((e) {
      Get.back();
      currentStatus.toggle();
    });
  }

  /// Inverts Current Status from reject
  void toggleOnlineButtonFromReject({
    required VoidCallback callback,
    required String messageStr,
  }) {
    currentStatus.value = false;

    String message = messageStr;

    Get.dialog(
      const ModalLoader(),
      barrierDismissible: false,
    );

    _statusService
        .updateDriverOnlineStatus(
      driverId: Get.find<DriverController>().driver.value.driverId,
      onlineStatus: currentStatus.value,
      latestLat: Get.find<LocationController>().currentLoc.value.latitude,
      latestLng: Get.find<LocationController>().currentLoc.value.longitude,
    )
        .then((result) {
      Get.back();

      Widget widget = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!currentStatus.value)
            const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.warning,
                color: Colors.white,
                size: 17,
              ),
            ),
          Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      );

      setOnlineStatus(
        isOnline: currentStatus.value,
        child: widget,
      );

      callback();
    }).catchError((e) {
      Get.back();
      currentStatus.toggle();
    });
  }
}
