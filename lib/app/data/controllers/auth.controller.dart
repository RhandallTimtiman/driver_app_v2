import 'package:driver_app/app/modules/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  RxBool obscureText = true.obs;

  TextEditingController userNameController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  GlobalKey<FormState> authFormKey = GlobalKey<FormState>();

  /// Toggles Visibility Of Field
  toggle() async {
    obscureText.value = !obscureText.value;
  }

  signIn() {
    if (authFormKey.currentState!.validate()) {
      debugPrint('Auth Action ===> Success!');
      Get.snackbar(
        'Success!',
        'Login Successful!',
        colorText: Colors.white,
        backgroundColor: Colors.green[500],
        duration: const Duration(
          seconds: 1,
        ),
      );
      Get.off(() => const HomeScreen());
    }
  }
}
