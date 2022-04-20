import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class NotificationController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getToken();
  }

  Future<String?> getToken() async {
    var result = await FirebaseMessaging.instance.getToken();

    GetStorage().write('deviceFcmToken', result);

    debugPrint('Assigned Token => $result');

    return result;
  }

  initializePushNotif() {
    FirebaseMessaging.onMessage.listen((event) {
      debugPrint('I receive a message hehe');
      final Map parsed = Platform.isIOS
          ? jsonDecode(event.data['info'])
          : jsonDecode(event.data['info']);

      if (parsed['NotificationType'] == 'newTrip') {
        inspect(parsed);
      }
    });
  }
}
