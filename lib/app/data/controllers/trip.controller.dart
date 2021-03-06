import 'dart:async';
import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/data/interfaces/interfaces.dart';
import 'package:driver_app/app/data/models/models.dart';
import 'package:driver_app/app/data/services/services.dart';
import 'package:driver_app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TripController extends GetxController {
  static TripController to = Get.find();

  List<Trip> tripList = [];

  List<Trip> tempTripList = [];

  TextEditingController searchController = TextEditingController();

  RxBool loading = false.obs;

  final state = CurrentState().obs;

  final ITrip tripService = TripService();

  void getTripList({type = 'New', filter = ''}) {
    setLoading(true);
    tripService
        .getTripByStatus(
      driverId: Get.find<DriverController>().driver.value.driverId.toString(),
      status: type,
    )
        .then(
      (value) {
        if (filter != '') {
          filterListByDate(filter, value);
        } else {
          setTempTripList(value);
          setTripList(value);
        }
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

  void getTripDetails({acquiredTruckingServiceId}) {
    setLoading(true);
    tripService
        .getTripDetails(acquiredTruckingServiceId: acquiredTruckingServiceId)
        .then(
          (value) => {
            setSelectedTrip(value),
            Get.toNamed('/trip'),
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

  updateCurrentAddress(String address) {
    state.value.location?.address = address;
    update();
  }

  void setTripList(List<Trip> list) {
    tripList = list;
    update();
  }

  void addTrip(Trip tr) {
    tripList.add(tr);
    update();
  }

  void clearTrips() {
    tripList.clear();
    update();
  }

  void setLoading(value) {
    loading.value = value;
    update();
  }

  void setSelectedTrip(Trip trip) {
    state.value.trip = trip;
    update();
  }

  void openAcceptModal(Trip trip) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.white,
        child: NewAcceptTripRequest(
          title: "Confirm Acceptance",
          trip: trip,
        ),
      ),
      barrierDismissible: false,
    );
  }

  void acceptTrip(int acquiredTruckingServiceId) {
    tripService
        .acceptTrip(
      driverId: Get.find<DriverController>().driver.value.driverId.toString(),
      acquiredTruckingServiceId: acquiredTruckingServiceId,
    )
        .then(
      (value) {
        setLoading(false);
        getTripDetails(
          acquiredTruckingServiceId: acquiredTruckingServiceId,
        );
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

  int calculateDifference(DateTime date) {
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day)
        .difference(
          DateTime(now.year, now.month, now.day),
        )
        .inDays;
  }

  void filterListByDate(String filter, List<Trip> trip) {
    List<Trip> _listItemsRaw = trip.where((trip) {
      bool isFiltered = true;
      switch (filter) {
        case 'today':
          isFiltered = calculateDifference(trip.deliveryDate) == 0;
          break;
        case 'upcoming':
          isFiltered = calculateDifference(trip.deliveryDate) >= 1;
          break;
        case 'missed':
          isFiltered = calculateDifference(trip.deliveryDate) < 0;
          break;
        default:
          isFiltered = true;
      }
      return isFiltered;
    }).toList();

    _listItemsRaw.sort((a, b) {
      var adate = a.deliveryDate;
      var bdate = b.deliveryDate;
      return filter == 'today' || filter == 'all'
          ? -adate.compareTo(bdate)
          : -bdate.compareTo(adate);
    });
    setTripList(_listItemsRaw);
    clearTempTrip();
  }

  void clearSearchValue() {
    searchController.text = '';
    setTripList(tempTripList);
    update();
  }

  void filterTripListBySearch(String filter) {
    List<Trip> filteredList = <Trip>[];
    if (filter.isNotEmpty) {
      filteredList = tempTripList.where((trip) {
        bool contains = trip.tripId
                .toLowerCase()
                .contains(filter.toString().toLowerCase()) ||
            trip.jobOrderNo
                .toLowerCase()
                .contains(filter.toString().toLowerCase());
        return contains;
      }).toList();
    } else {
      filteredList = tempTripList.map((e) => e).toList();
    }
    setTripList(filteredList);
  }

  void setTempTripList(List<Trip> list) {
    tempTripList = list;
    update();
  }

  void clearTempTrip() {
    tempTripList = tripList.map((e) => e).toList();
    update();
  }

  void acceptAllTrip(context) {
    List<Map<String, dynamic>> listOfacquiredTruckingServiceId = tripList
        .where((trip) => trip.statusId == 'NEW')
        .map(
          (trip) => {
            "acquiredTruckingServiceId":
                trip.acquiredTruckingServiceId.toString()
          },
        )
        .toList();
    if (listOfacquiredTruckingServiceId.isNotEmpty) {
      tripService
          .acceptAllTrip(
        trips: listOfacquiredTruckingServiceId,
        driverId: Get.find<DriverController>().driver.value.driverId!,
      )
          .then(
        (value) {
          Get.back();
          Get.snackbar(
            'success_snackbar_title'.tr,
            'All trips are accepted!',
            colorText: Colors.white,
            backgroundColor: Colors.green[500],
            duration: const Duration(
              seconds: 2,
            ),
            margin: const EdgeInsets.all(15),
            snackPosition: SnackPosition.BOTTOM,
          );
          Navigator.pop(context);
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
    } else {
      setLoading(false);
      Get.back();
      Get.snackbar(
        'error_snackbar_title'.tr,
        'There are no trips to accept.',
        backgroundColor: Colors.red[400],
        colorText: Colors.white,
        duration: const Duration(
          seconds: 2,
        ),
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(15),
      );
    }
  }

  void openAcceptAllModal() {
    Get.dialog(
      const Dialog(
        backgroundColor: Colors.white,
        child: AcceptAllTripModal(),
      ),
      barrierDismissible: false,
    );
  }

  void handleCurrentTrip({required Trip trip}) {
    setSelectedTrip(trip);
    update();
    Timer(
      const Duration(milliseconds: 500),
      () {
        Get.toNamed('/trip');
      },
    );
  }
}
