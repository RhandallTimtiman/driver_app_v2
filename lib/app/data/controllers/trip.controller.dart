import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/data/interfaces/interfaces.dart';
import 'package:driver_app/app/data/models/models.dart';
import 'package:driver_app/app/data/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TripController extends GetxController {
  static TripController to = Get.find();

  List<Trip> tripList = [];

  TextEditingController searchController = TextEditingController();

  RxBool loading = false.obs;

  final ITrip tripService = TripService();

  final selectedTrip = CurrentState().obs;

  void getTripList({type = 'New'}) {
    setLoading(true);
    tripService
        .getTripByStatus(
          driverId:
              Get.find<DriverController>().driver.value.driverId.toString(),
          status: type,
        )
        .then(
          (value) => {
            setTripList(value),
            setLoading(false),
          },
        )
        .catchError(
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

  void handleSelectedTrip({trip}) {
    setSelectedTrip(trip);
    Get.toNamed('/trip');
  }

  setTripList(List<Trip> list) {
    tripList = list;
    update();
  }

  addTrip(Trip tr) {
    tripList.add(tr);
    update();
  }

  clearTrips() {
    tripList.clear();
    update();
  }

  void setLoading(value) {
    loading.value = value;
    update();
  }

  setSelectedTrip(Trip trip) {
    selectedTrip.value.trip = trip;
    update();
  }
}
