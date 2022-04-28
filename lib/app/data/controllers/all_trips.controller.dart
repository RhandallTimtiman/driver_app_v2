import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/data/interfaces/interfaces.dart';
import 'package:driver_app/app/data/models/models.dart';
import 'package:driver_app/app/data/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllTripsController extends GetxController {
  TextEditingController allTripsSearchController = TextEditingController();

  RxList<Trip> tripList = <Trip>[].obs;

  final ITrip tripService = TripService();

  RxBool isLoaded = false.obs;

  RxList<Trip> tempTripList = <Trip>[].obs;

  @override
  void onInit() {
    setLoading(true);
    super.onInit();
  }

  @override
  void dispose() {
    allTripsSearchController.text = '';
    super.dispose();
  }

  void getTripList({isPulled = false}) {
    setLoading(!isPulled);
    setTripList([]);
    tripService
        .getTripByStatus(
          driverId:
              Get.find<DriverController>().driver.value.driverId.toString(),
          status: 'All',
        )
        .then(
          (value) => {
            debugPrint('I was called.'),
            setTripList(value),
            setTempTripList(value),
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
    tripList.value = value;
    update();
  }

  void setTempTripList(List<Trip> value) {
    tempTripList.value = value;
    update();
  }

  void setLoading(bool value) {
    isLoaded.value = value;
    update();
  }

  void searchTrips(String value) {
    debugPrint(allTripsSearchController.text);
    if (value.isEmpty) {
      // ignore: invalid_use_of_protected_member
      tripList.value = tempTripList.value;
      update();
    } else {
      tripList.value = tempTripList
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
    allTripsSearchController.text = '';
    setTripList(tempTripList);
    update();
  }
}
