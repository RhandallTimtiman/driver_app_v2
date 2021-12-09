import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:connectivity/connectivity.dart';

class ConnectivityController extends GetxController {
  var navigatorKey = GlobalKey<NavigatorState>();

  @override
  void onInit() {
    super.onInit();

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result.index != 2) {
        debugPrint('Connection Status ====> Connected!');

        Get.back();
      } else {
        debugPrint('Connection Status ====> Not Connected!');
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
                        "Please check your Internet Connection",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          barrierDismissible: false,
          navigatorKey: navigatorKey,
        );
      }
    });
  }
}
