import 'dart:developer';

import 'package:driver_app/app/data/models/models.dart';
import 'package:get/get.dart';

class CurrentTripController extends GetxController {
  static CurrentTripController to = Get.find();

  final currentTrip = CurrentState().obs;

  RxBool loading = false.obs;

  void handleCurrentTrip({trip}) {
    setSelectedTrip(trip);
    Get.toNamed('/trip');
  }

  void setSelectedTrip(Trip trip) {
    currentTrip.value.trip = trip;
    inspect(trip);
    update();
  }
}
