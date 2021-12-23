import 'dart:async';

import 'package:driver_app/app/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatusController extends GetxController {
  final onlineStatus = Status().obs;

  static Timer? toastTimer;

  final currentStatus = false.obs;

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
  void toggleCurrentStatus() {
    currentStatus.toggle();

    String message =
        currentStatus.value ? 'You are now Online!' : 'You are now Offline!';

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
  }
}
