import 'dart:developer';

import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/data/interfaces/interfaces.dart';
import 'package:driver_app/app/data/models/models.dart';
import 'package:driver_app/app/data/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PendingTripsController extends GetxController {
  TextEditingController pendingTripsSearchController = TextEditingController();

  final pendingTripList = <Trip>[].obs;

  final ITrip tripService = TripService();

  RxBool loading = false.obs;

  RxList<Trip> tempTripList = <Trip>[].obs;

  @override
  void onInit() {
    setLoading(true);
    super.onInit();
  }

  @override
  void dispose() {
    pendingTripsSearchController.text = '';
    super.dispose();
  }

  void getTripList({isPulled = false}) {
    setLoading(!isPulled);
    tripService
        .getTripByStatus(
      driverId: Get.find<DriverController>().driver.value.driverId.toString(),
      status: 'PEN,ONG',
    )
        .then(
      (value) {
        setTripList(value);
        setTempTripList(value);
        setLoading(false);
      },
    ).catchError(
      (error) {
        setLoading(false);
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
      },
    );
  }

  void setTripList(List<Trip> value) {
    pendingTripList.value = value;
    update();
  }

  void setTempTripList(List<Trip> value) {
    tempTripList.value = value;
    update();
  }

  void setLoading(value) {
    loading.value = value;
    update();
  }

  void searchTrips(String value) {
    if (value.isEmpty) {
      pendingTripList.value = tempTripList.map((element) => element).toList();
      update();
    } else {
      pendingTripList.value = tempTripList
          .where((element) =>
              element.tripId
                  .toLowerCase()
                  .contains(value.toString().toLowerCase()) ||
              element.jobOrderNo
                  .toLowerCase()
                  .contains(value.toString().toLowerCase()))
          .toList();

      update();
    }
  }

  void clearSearch() {
    pendingTripsSearchController.text = '';
    setTripList(tempTripList);
  }
}
