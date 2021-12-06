import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  RxBool obscureText = true.obs;

  TextEditingController userNameController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  final authFormKey = GlobalKey<FormState>();

  /// Toggles Visibility Of Field
  toggle() async {
    obscureText.value = !obscureText.value;
  }

  signIn() {
    if (authFormKey.currentState!.validate()) {
      debugPrint('Auth Action ===> Success!');
    }
  }
}
