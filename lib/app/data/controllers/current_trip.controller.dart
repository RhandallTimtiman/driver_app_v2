import 'dart:async';
import 'dart:developer';
import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/data/interfaces/interfaces.dart';
import 'package:driver_app/app/data/models/models.dart';
import 'package:driver_app/app/data/services/services.dart';
import 'package:driver_app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class CurrentTripController extends GetxController {
  static CurrentTripController to = Get.find();

  final currentTrip = CurrentState().obs;

  RxBool loading = false.obs;

  final ICurrentTrip currentTripService = CurrentTripService();

  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  @override
  void onInit() {
    debugPrint('==> in initialize');
    setSelectedTrip(Get.find<TripController>().state.value.trip);
    googleGetRouteDetails();
    super.onInit();
  }

  void handleCurrentTrip({trip}) {
    setSelectedTrip(trip);
    Get.toNamed('/trip');
  }

  void setSelectedTrip(Trip trip) {
    inspect(trip);
    currentTrip.value.trip = trip;
    update();
  }

  void updateIsOrigin(bool isOrigin) {
    currentTrip.value.trip.isOrigin = isOrigin;
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

  googleGetRouteDetails() async {
    Trip trip = currentTrip.value.trip;
    Get.find<TripScreenMapGoogleController>().getRouteDetails(
      originLat: trip.origin.latitude,
      originLng: trip.origin.longitude,
      destLat: trip.destination.latitude,
      destLng: trip.destination.longitude,
    );
  }

  getOnGoingTrip() {
    if (currentTrip.value.trip.statusId == 'PEN') {
      currentTripService
          .getTripByStatus(
              driverId: Get.find<DriverController>().driver.value.driverId!,
              status: 'ONG')
          .then(
        (value) {
          if (value.length > 0) {
            setLoading();
            Get.find<OngoingTripController>().checkIfHasPendingTrip();
          } else {
            _showConfirmStartTrip();
          }
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
    } else {
      if (currentTrip.value.trip.isOrigin) {
        _showConfirmArrival(
          currentTrip.value.trip.acquiredTruckingServiceId,
        );
      }
    }
  }

  void _showConfirmStartTrip() {
    Get.dialog(
      AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            20.0,
          ),
        ),
        content: ConfirmArrival(
          isOrigin: true,
          status: 'ONG',
          acquiredTruckingServiceId:
              currentTrip.value.trip.acquiredTruckingServiceId,
          title: 'Confirm Start Trip',
          message: 'Do you want to proceed starting the trip?',
          routeName: 'Route ${currentTrip.value.trip.routeName}',
          address: currentTrip.value.trip.origin.address,
          instruction: currentTrip.value.trip.origin.instruction!,
          callback: updateStatus,
        ),
      ),
      barrierDismissible: true,
    );
  }

  updateStatus(
      int acquiredTruckingServiceId, String status, bool isOrigin) async {
    setLoading();
    var geo = await _geolocatorPlatform.getCurrentPosition().timeout(
          const Duration(
            seconds: 5,
          ),
        );
    if (status == 'ONG') {
      try {
        var eta = await getEstimatedDistance(
          Coordinates(
            lat: geo.latitude,
            lng: geo.longitude,
          ),
          Coordinates(
            lat: currentTrip.value.trip.origin.latitude,
            lng: currentTrip.value.trip.origin.longitude,
          ),
        );
        var today = DateTime.now();
        DateTime etaDate = today.add(
          Duration(seconds: eta),
        );
        debugPrint('started trip');
        await currentTripService.updateActualStartTime(
          acquiredTruckingServiceId:
              currentTrip.value.trip.acquiredTruckingServiceId,
          driverId: currentTrip.value.trip.driverId,
          lat: geo.latitude,
          lng: geo.longitude,
          eta: etaDate,
        );
        Trip trip = await updateStatus(
          acquiredTruckingServiceId,
          status,
          isOrigin,
        );
        setSelectedTrip(trip);
        setLoading();
      } catch (error) {
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
      }
    }
  }

  getEstimatedDistance(
    Coordinates startGeoCoordinates,
    Coordinates destinationGeoCoordinates,
  ) async {
    var completer = Completer<int>();
    await currentTripService
        .getEstimatedRouteDistance(
      originLatitude: startGeoCoordinates.lat,
      originLongitude: startGeoCoordinates.lng,
      destinationLatitude: destinationGeoCoordinates.lat,
      destinationLongitude: destinationGeoCoordinates.lng,
    )
        .then((result) {
      completer.complete(result);
    }).catchError((err) {
      completer.complete(0);
    });
    return completer.future;
  }

  updateCurrentTrip(String status, bool isOrigin) {
    currentTripService
        .updateTrip(
      acquiredTruckingServiceId:
          currentTrip.value.trip.acquiredTruckingServiceId,
      status: status,
      isOrigin: isOrigin,
    )
        .then(
      (value) {
        return value;
      },
    ).catchError(
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

  void _showConfirmArrival(int acquiredTruckingServiceId) {
    Get.dialog(
      AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            20.0,
          ),
        ),
        content: ConfirmArrival(
          isOrigin: true,
          status: 'ONG',
          acquiredTruckingServiceId:
              currentTrip.value.trip.acquiredTruckingServiceId,
          title: 'Confirm Arrival',
          message: 'Have you safely arrived?',
          routeName: 'Route ${currentTrip.value.trip.routeName}',
          address: currentTrip.value.trip.origin.address,
          instruction: currentTrip.value.trip.origin.instruction!,
          callback: openArrivalCompletion,
        ),
      ),
      barrierDismissible: true,
    );
  }

  openArrivalCompletion(int tripNo, String status, bool isOrigin) {
    Get.bottomSheet(
      const RouteCompletionArrival(),
      isScrollControlled: true,
    );
  }

  updateCurrentLocation(double lat, double long) {
    currentTrip.value.location.latitude = lat;
    currentTrip.value.location.longitude = long;
    update();
  }

  updateCurrentAddress(String address) {
    currentTrip.value.location.address = address;
    update();
  }
}
