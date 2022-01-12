import 'package:driver_app/app/data/interfaces/interfaces.dart';
import 'package:driver_app/app/data/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePinController extends GetxController {
  RxBool obscureText = true.obs;

  TextEditingController oldPinController = TextEditingController();
  TextEditingController newPinController = TextEditingController();
  TextEditingController confirmPinController = TextEditingController();

  final ISettings _settingsService = SettingsService();

  void toggle() async {
    obscureText.toggle();
  }

  void changeNewPin(context, driverId) {
    if (oldPinController.text.length < 6 ||
        newPinController.text.length < 6 ||
        confirmPinController.text.length < 6) {
      Get.snackbar(
        'error_snackbar_title'.tr,
        'Please input 6 digit pin!',
        backgroundColor: Colors.red[400],
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(
          seconds: 2,
        ),
        margin: const EdgeInsets.all(15),
      );
    } else if (newPinController.text != confirmPinController.text) {
      Get.snackbar(
        'error_snackbar_title'.tr,
        'New Pin and Confirm Pin does not match!',
        backgroundColor: Colors.red[400],
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(
          seconds: 2,
        ),
        margin: const EdgeInsets.all(15),
      );
    } else {
      _settingsService
          .changePin(driverId, oldPinController.text, newPinController.text)
          .then(
        (result) {
          if (result['isSuccessful']) {
            Get.snackbar(
              'success_snackbar_title'.tr,
              'Pin successfully changed.',
              colorText: Colors.white,
              backgroundColor: Colors.green[500],
              duration: const Duration(
                seconds: 2,
              ),
              margin: const EdgeInsets.all(15),
              snackPosition: SnackPosition.BOTTOM,
              snackbarStatus: (status) {
                if (status == SnackbarStatus.CLOSED) {
                  oldPinController.clear();
                  newPinController.clear();
                  confirmPinController.clear();
                  Navigator.of(context).pop();
                }
              },
            );
          }
        },
      ).catchError(
        (error) {
          Get.snackbar(
            'error_snackbar_title'.tr,
            error.message,
            backgroundColor: Colors.red[400],
            colorText: Colors.white,
            duration: const Duration(
              seconds: 2,
            ),
            snackPosition: SnackPosition.BOTTOM,
            margin: const EdgeInsets.all(15),
          );
        },
      );
    }
  }
}
