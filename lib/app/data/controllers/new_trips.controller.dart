import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/data/interfaces/interfaces.dart';
import 'package:driver_app/app/data/models/models.dart';
import 'package:driver_app/app/data/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewTripsController extends GetxController {
  final newTripList = <Trip>[].obs;

  TextEditingController newTripsSearchController = TextEditingController();

  RxBool loading = false.obs;

  final ITrip tripService = TripService();

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
          status: 'NEW',
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
    newTripList.value = value;
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
    debugPrint(newTripsSearchController.text);
    if (value.isEmpty) {
      // ignore: invalid_use_of_protected_member
      newTripList.value = tempTripList.value;
      update();
    } else {
      newTripList.value = tempTripList
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
