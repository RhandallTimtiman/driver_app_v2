import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/data/interfaces/interfaces.dart';
import 'package:driver_app/app/data/models/models.dart';
import 'package:driver_app/app/data/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompletedTripsController extends GetxController {
  TextEditingController completedTripsSearchController =
      TextEditingController();

  final completedTripList = <Trip>[].obs;

  final ITrip tripService = TripService();

  RxBool loading = false.obs;
  @override
  void onInit() {
    getTripList();
    super.onInit();
  }

  void getTripList() {
    setLoading();
    tripService
        .getTripByStatus(
          driverId:
              Get.find<DriverController>().driver.value.driverId.toString(),
          status: 'COM',
        )
        .then(
          (value) => {
            setTripList(value),
            setLoading(),
          },
        )
        .catchError(
      (error) {
        setLoading();
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
    completedTripList.value = value;
    update();
  }

  void setLoading() {
    loading.toggle();
  }
}
