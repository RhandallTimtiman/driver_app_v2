import 'package:driver_app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OngoingTripController extends GetxController {
  RxBool hasOnGoingTrip = false.obs;

  void setHasOnGoingTrip(bool value) {
    hasOnGoingTrip.value = value;
  }

  void checkIfHasPendingTrip() {
    Get.dialog(
      AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            20.0,
          ),
        ),
        content: const HasOnGoingTrip(),
      ),
      barrierDismissible: true,
    );
  }
}
