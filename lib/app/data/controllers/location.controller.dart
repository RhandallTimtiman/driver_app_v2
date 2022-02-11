import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:location/location.dart';

class LocationController extends GetxController {
  Location location = Location();

  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;

  @override
  void onInit() {
    super.onInit();
  }

  /// Initialize Location Service
  startLocationService() async {
    if (_permissionGranted == PermissionStatus.granted && _serviceEnabled) {
      debugPrint('Location ====> Activated!');

      var isEnabledBackground = await location.isBackgroundModeEnabled();

      if (!isEnabledBackground) {
        location.enableBackgroundMode(enable: true);
      }

      location.changeSettings(
        distanceFilter: 20,
      );

      if (Platform.isAndroid) {
        location.changeNotificationOptions(
          title: "Driver App Locator",
          onTapBringToFront: true,
          description: "Do not turn off GPS Service",
          subtitle: "This Device is currently sending active location",
          color: Colors.green[800],
        );
      }

      location.onLocationChanged.listen((LocationData currentLocation) {
        debugPrint('${currentLocation.latitude}, ${currentLocation.longitude}');
      });
    }
  }

  /// Checks Permission of Driver App
  checkPermissions({isDisclosure = true}) async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    if (isDisclosure) {
      Get.offAllNamed('/login');
      GetStorage().write('disclosure', true);
    }

    startLocationService();
  }
}
