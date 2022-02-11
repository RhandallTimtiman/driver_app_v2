import 'dart:convert';

import 'package:driver_app/app/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'controllers.dart';

class SessionController extends GetxController {
  RxBool hasSession = false.obs;

  @override
  void onInit() {
    super.onInit();
    hasPreviousSession();
  }

  /// Toggle hasSession
  void toggleHasSession() {
    hasSession.toggle();
  }

  /// Set Value of hasSession
  void setHasSession(bool value) {
    hasSession.value = value;
    update();
  }

  /// Check if User has previous Session
  void hasPreviousSession() {
    bool hasSession = GetStorage().hasData('user');

    if (hasSession) {
      debugPrint('User Has Previous Session ===>');
      Get.find<DriverController>()
          .setDriver(Driver.fromJson(jsonDecode(GetStorage().read('user'))));
      setHasSession(true);
    } else {
      debugPrint('User Has No Previous Session ===>');
      setHasSession(false);
    }
  }
}
