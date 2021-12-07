import 'package:driver_app/app/modules/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  RxBool obscureText = true.obs;

  TextEditingController userNameController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  final authFormKey = GlobalKey<FormState>();

  /// Toggles Visibility Of Field
  void toggle() async {
    obscureText.toggle();
  }

  /// Sign In Functionality
  void signIn() {
    if (authFormKey.currentState!.validate()) {
      debugPrint('Auth Action ===> Success!');
      Get.snackbar(
        'Success!',
        'Login Successful!',
        colorText: Colors.white,
        backgroundColor: Colors.green[500],
      );
      // Get.off(() => const HomeScreen());
      Get.to(() => const HomeScreen());
    }
  }
}
