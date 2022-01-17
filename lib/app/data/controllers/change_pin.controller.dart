import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/data/interfaces/interfaces.dart';
import 'package:driver_app/app/data/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePinController extends GetxController {
  RxBool obscureText = true.obs;

  TextEditingController oldPinController = TextEditingController();
  TextEditingController newPinController = TextEditingController();
  TextEditingController confirmPinController = TextEditingController();

  GlobalKey<FormState> changePinFormKey = GlobalKey<FormState>();

  final ISettings _settingsService = SettingsService();

  void toggle() async {
    obscureText.toggle();
  }

  void changeNewPin() {
    if (changePinFormKey.currentState!.validate()) {
      _settingsService
          .changePin(
        driverId: Get.find<DriverController>().driver.value.driverId,
        oldPin: oldPinController.text,
        newPin: newPinController.text,
      )
          .then(
        (result) {
          if (result.isSuccessful) {
            Get.snackbar(
              'success_snackbar_title'.tr,
              'pin_change_success'.tr,
              colorText: Colors.white,
              backgroundColor: Colors.green[500],
              duration: const Duration(
                seconds: 2,
              ),
              margin: const EdgeInsets.all(15),
              snackPosition: SnackPosition.BOTTOM,
              snackbarStatus: (status) {
                if (status == SnackbarStatus.CLOSED) {
                  closeChangePinModal();
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

  bool pinLengthValidator(String pin) {
    return (pin.length > 6 || pin.length < 6);
  }

  bool newPinOldPinValidator(String pin) {
    return (newPinController.text != confirmPinController.text);
  }

  void closeChangePinModal() {
    oldPinController.clear();
    newPinController.clear();
    confirmPinController.clear();
    Get.back();
  }
}
