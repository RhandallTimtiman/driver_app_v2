import 'dart:developer';

import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/data/interfaces/interfaces.dart';
import 'package:driver_app/app/data/models/models.dart';
import 'package:driver_app/app/data/services/services.dart';
import 'package:driver_app/app/modules/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  RxBool obscureText = true.obs;

  TextEditingController userNameController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  GlobalKey<FormState> authFormKey = GlobalKey<FormState>();

  final IAuth _authService = AuthService();

  /// Toggles Visibility Of Field
  void toggle() async {
    obscureText.toggle();
  }

  /// Sign In Functionality
  Future<void> signIn() async {
    if (authFormKey.currentState!.validate()) {
      Get.dialog(
        Dialog(
          backgroundColor: Colors.white12,
          child: SizedBox(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    CircularProgressIndicator(
                      strokeWidth: 7.0,
                      backgroundColor: Color.fromRGBO(244, 162, 64, 1),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Please wait...",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        barrierDismissible: false,
      );

      _authService
          .signIn(username: userNameController.text, pin: pinController.text)
          .then((result) {
        inspect(result);
        Get.find<DriverController>().setDriver();
        Get.back();
        Get.snackbar(
          'Success!',
          'Login Successful!',
          colorText: Colors.white,
          backgroundColor: Colors.green[500],
          duration: const Duration(
            seconds: 2,
          ),
        );
        Get.off(() => const HomeScreen());
      }).catchError((error) {
        Get.back();
        Get.snackbar(
          "Error!",
          error.message,
          backgroundColor: Colors.red[400],
          colorText: Colors.white,
          duration: const Duration(
            seconds: 2,
          ),
        );
      });
    }
  }
}
