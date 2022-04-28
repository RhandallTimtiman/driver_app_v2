import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:driver_app/app/data/interfaces/interfaces.dart';
import 'package:driver_app/app/data/models/models.dart';
import 'package:driver_app/app/data/services/services.dart';
import 'package:driver_app/app/widgets/widgets.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class NotificationController extends GetxController {
  final ITrip _tripService = TripService();

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
        _tripService
            .getNewTrip(
          driverId: parsed['DriverId'],
          jobOrder: parsed['JobOrderId'],
        )
            .then((result) {
          bool isAccepted = false;

          List<dynamic> tempTrips = result;

          List<Trip> trips = tempTrips.cast<Trip>();

          inspect(trips);

          Future.forEach(trips, (Trip trip) async {
            if (isAccepted != true) {
              isAccepted = await Get.dialog(
                Dialog(
                  backgroundColor: Colors.white,
                  child: NewAcceptTripRequest(
                    title: "new_trip_request".tr,
                    trip: trip,
                    isFromNotification: true,
                  ),
                ),
                barrierDismissible: false,
              );

              debugPrint('Was he Accepted? $isAccepted');
            }
          });
        }).catchError((onError) {
          inspect(onError);
        });
      }
    });
  }
}
