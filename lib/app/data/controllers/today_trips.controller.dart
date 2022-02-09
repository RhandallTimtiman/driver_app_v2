import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/data/interfaces/interfaces.dart';
import 'package:driver_app/app/data/models/models.dart';
import 'package:driver_app/app/data/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodayTripsController extends GetxController {
  TextEditingController todayTripsSearchController = TextEditingController();

  final todayTripList = <Trip>[].obs;

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
          status: 'TODAY',
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
    todayTripList.value = value;
    update();
  }

  void setLoading() {
    loading.toggle();
  }
}
