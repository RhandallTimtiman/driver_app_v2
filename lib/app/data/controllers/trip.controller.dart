import 'dart:developer';

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

  List<Trip> filteredTripList = [];

  TextEditingController searchController = TextEditingController();

  String searchValue = '';

  RxBool loading = false.obs;

  final ITrip tripService = TripService();

  void getTripList({type = 'New', filter = ''}) {
    setLoading(true);
    tripService
        .getTripByStatus(
          driverId:
              Get.find<DriverController>().driver.value.driverId.toString(),
          status: type,
        )
        .then(
          (value) => {
            if (filter != '')
              {filterListByDate(filter, value)}
            else
              {
                setTripList(value),
              },
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

  void getTripDetails({acquiredTruckingServiceId}) {
    setLoading(true);
    tripService
        .getTripDetails(acquiredTruckingServiceId: acquiredTruckingServiceId)
        .then(
          (value) => {
            Get.find<CurrentTripController>().setSelectedTrip(value),
            Get.toNamed('/trip')
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
    Get.find<CurrentTripController>().setSelectedTrip(trip);
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
    debugPrint(Get.find<DriverController>().driver.value.driverId.toString());
    tripService
        .acceptTrip(
          driverId:
              Get.find<DriverController>().driver.value.driverId.toString(),
          acquiredTruckingServiceId: acquiredTruckingServiceId,
        )
        .then(
          (value) => {
            getTripDetails(acquiredTruckingServiceId: acquiredTruckingServiceId)
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
    clearFilteredTripList();
  }

  void setSearchValue(value) {
    searchValue = value;
    // update();
    // filterTripListBySearch();
  }

  void clearSearchValue() {
    searchValue = '';
    searchController.text = '';
    setFilteredTripList(tripList);
    update();
  }

  void filterTripListBySearch() {
    debugPrint(searchValue);
    List<Trip> filteredList = tripList.where((element) {
      bool contains = element.tripId
              .toLowerCase()
              .contains(searchValue.toString().toLowerCase()) ||
          element.jobOrderNo
              .toLowerCase()
              .contains(searchValue.toString().toLowerCase());
      return contains;
    }).toList();
    setFilteredTripList(filteredList);
  }

  void setFilteredTripList(List<Trip> list) {
    filteredTripList = list;
    update();
  }

  void clearFilteredTripList() {
    filteredTripList = tripList;
    update();
  }
}
