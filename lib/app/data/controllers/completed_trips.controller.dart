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

  RxList<Trip> tempTripList = <Trip>[].obs;

  @override
  void onInit() {
    setLoading(true);
    super.onInit();
  }

  void getTripList({isPulled = false}) {
    setLoading(!isPulled);
    tripService
        .getTripByStatus(
          driverId:
              Get.find<DriverController>().driver.value.driverId.toString(),
          status: 'COM',
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

  void setTripList(List<Trip> value) {
    completedTripList.value = value;
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
    debugPrint(completedTripsSearchController.text);
    if (value.isEmpty) {
      // ignore: invalid_use_of_protected_member
      completedTripList.value = tempTripList.value;
      update();
    } else {
      completedTripList.value = tempTripList
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
}
