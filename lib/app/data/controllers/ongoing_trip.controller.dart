import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/data/interfaces/interfaces.dart';
import 'package:driver_app/app/data/models/models.dart';
import 'package:driver_app/app/data/services/services.dart';
import 'package:driver_app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OngoingTripController extends GetxController {
  RxBool hasOnGoingTrip = false.obs;
  final ITrip tripService = TripService();
  OnGoingTrip onGoingTrip = OnGoingTrip();

  void setHasOnGoingTrip(bool value) {
    hasOnGoingTrip.value = value;
    update();
  }

  void checkIfHasPendingTrip() {
    tripService
        .getTripByStatus(
      driverId: Get.find<DriverController>().driver.value.driverId!.toString(),
      status: 'ONG',
    )
        .then((value) {
      if (value.length > 0) {
        List<Trip> tripList = value;
        Trip trip =
            tripList.where((element) => element.statusId == 'ONG').first;
        setHasOnGoingTrip(true);
        openHasOngoingTrip(trip);
        setOnGoingTrip(trip);
      }
    }).catchError((error) {
      Get.snackbar(
        'error_snackbar_title'.tr,
        error.toString(),
        backgroundColor: Colors.red[400],
        colorText: Colors.white,
        duration: const Duration(
          seconds: 4,
        ),
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(15),
      );
    });
  }

  openHasOngoingTrip(Trip trip) {
    Get.dialog(
      AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            20.0,
          ),
        ),
        content: HasOnGoingTrip(
          trip: trip,
        ),
      ),
      barrierDismissible: false,
    );
  }

  setOnGoingTrip(Trip trip) {
    onGoingTrip = OnGoingTrip(
      acquiredTruckingServiceId: trip.acquiredTruckingServiceId,
      tripId: trip.tripId,
    );
  }
}
