import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/data/interfaces/interfaces.dart';
import 'package:driver_app/app/data/models/models.dart';
import 'package:driver_app/app/data/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CurrentTripController extends GetxController {
  static CurrentTripController to = Get.find();

  final currentTrip = CurrentState().obs;

  RxBool loading = false.obs;

  final ICurrentTrip currentTripService = CurrentTripService();

  @override
  void onInit() {
    setSelectedTrip(Get.find<TripController>().state.value.trip);
    super.onInit();
  }

  void handleCurrentTrip({trip}) {
    setSelectedTrip(trip);
    Get.toNamed('/trip');
  }

  void setSelectedTrip(Trip trip) {
    currentTrip.value.trip = trip;
    update();
  }

  getTripSummary() {
    setLoading();
    currentTripService
        .getTripSummary(
      acquiredTruckingServiceId:
          currentTrip.value.trip.acquiredTruckingServiceId,
    )
        .then(
      (tripSummary) {
        setLoading();
        setTripSummary(tripSummary);
        Get.toNamed('/trip-summary');
      },
    ).catchError(
      (error) {
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

  void setTripSummary(TripSummaryModel tripSummary) {
    currentTrip.value.tripSummary = tripSummary;
  }

  void setLoading() {
    loading.toggle();
    update();
  }
}
