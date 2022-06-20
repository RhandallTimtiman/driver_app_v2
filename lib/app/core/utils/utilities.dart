import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Utilities {
  void logout() {
    Get.snackbar(
      'error_snackbar_title'.tr,
      'token_expired_label'.tr,
      backgroundColor: Colors.red[400],
      colorText: Colors.white,
      duration: const Duration(
        seconds: 2,
      ),
    );
    Get.find<OngoingTripController>().setHasOnGoingTrip(false);
    Get.find<DriverController>().clearDriver();

    Get.find<LocationController>().disposeListener();
    GetStorage().remove('user');
    Get.offAllNamed('/login');
  }
}
