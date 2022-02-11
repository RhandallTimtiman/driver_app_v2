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
    GetStorage().remove('user');
    Get.offAllNamed('/login');
  }
}
