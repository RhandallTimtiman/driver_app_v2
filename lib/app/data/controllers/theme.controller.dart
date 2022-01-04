import 'package:driver_app/app/core/constants/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  RxBool isDarkMode = false.obs;

  void changeTheme() {
    Get.changeTheme(
      Get.isDarkMode ? AppThemes.lightTheme : ThemeData.dark(),
    );
    isDarkMode.toggle();
  }
}
