import 'package:driver_app/app/core/utils/validators.dart';
import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/data/interfaces/interfaces.dart';
import 'package:driver_app/app/data/services/services.dart';
import 'package:driver_app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePinController extends GetxController {
  RxBool obscureOldPin = true.obs;
  RxBool obsecureNewPin = true.obs;
  RxBool obsecureConfirmPin = true.obs;

  TextEditingController oldPinController = TextEditingController();
  TextEditingController newPinController = TextEditingController();
  TextEditingController confirmPinController = TextEditingController();

  GlobalKey<FormState> changePinFormKey = GlobalKey<FormState>();

  final ISettings _settingsService = SettingsService();

  /// Toggles Visibility Of Field
  void toggleOldPin() async {
    obscureOldPin.toggle();
  }

  void toggleNewPin() async {
    obsecureNewPin.toggle();
  }

  void toggleConfirmPin() async {
    obsecureConfirmPin.toggle();
  }

  void changeNewPin() {
    if (changePinFormKey.currentState!.validate()) {
      Get.dialog(
        const BackgroundLoader(),
        barrierDismissible: false,
      );
      _settingsService
          .changePin(
        driverId: Get.find<DriverController>().driver.value.driverId,
        oldPin: oldPinController.text,
        newPin: newPinController.text,
      )
          .then(
        (result) {
          if (result.isSuccessful) {
            Get.back();
            closeChangePinModal();
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
            );
          }
        },
      ).catchError(
        (error) {
          Get.back();
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

  void closeChangePinModal() {
    oldPinController.clear();
    newPinController.clear();
    confirmPinController.clear();
    Get.back();
  }

  bool newPinConfirmPinValidator(String pin) {
    return Validators.newPinConfirmPinValidator(newPinController.text, pin);
  }
}
