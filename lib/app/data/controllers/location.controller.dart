import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/data/interfaces/interfaces.dart';
import 'package:driver_app/app/data/models/models.dart';
import 'package:driver_app/app/data/services/services.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LocationController extends GetxController {
  final Rx<CurrentPosition> currentLoc = CurrentPosition().obs;

  final ITrip tripService = TripService();

  final IDriver driverService = DriverService();

  List<dynamic> coordinates = [];

  StreamSubscription<Position>? positionStream;

  setCurrentLocation(var data) {
    currentLoc.value = data;
    update();
  }

  /// Initialize Location Service
  startLocationService() async {
    late LocationSettings locationSettings;

    if (defaultTargetPlatform == TargetPlatform.android) {
      locationSettings = AndroidSettings(
        // forceLocationManager: true,
        accuracy: LocationAccuracy.high,
        foregroundNotificationConfig: const ForegroundNotificationConfig(
          notificationText:
              "Driver App will continue to receive your location even when you aren't using it",
          notificationTitle: "Running in Background",
          enableWakeLock: true,
        ),
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      locationSettings = AppleSettings(
        accuracy: LocationAccuracy.high,
        activityType: ActivityType.fitness,
        distanceFilter: 10,
        pauseLocationUpdatesAutomatically: true,
        // Only set to true if our app will be started up in the background.
        showBackgroundLocationIndicator: true,
      );
    } else {
      locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      );
    }
    int count = 0;
    int sendDriverLocCount = 0;
    positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings).listen(
      (Position? position) async {
        if (position != null) {
          setCurrentLocation(
            CurrentPosition(
              latitude: position.latitude,
              longitude: position.longitude,
              accuracy: position.accuracy,
              heading: position.heading,
            ),
          );

          var locations = GetStorage().read('locations');
          if (locations != null) {
            debugPrint('====> call bulk location');
            sendBulkLocation(json.decode(locations));
          }

          bool hasOnGoingTrip =
              Get.find<OngoingTripController>().hasOnGoingTrip.value;
          if (count % 20 == 0) {
            if (hasOnGoingTrip) {
              OnGoingTrip onGoingTrip =
                  Get.find<OngoingTripController>().onGoingTrip;
              tripService
                  .addTrackingHistory(
                acquiredTruckingServiceId:
                    onGoingTrip.acquiredTruckingServiceId.toString(),
                tripId: onGoingTrip.tripId.toString(),
                latitude: position.latitude,
                longitude: position.longitude,
              )
                  .catchError((onError) {
                addLocation(
                  acquiredTruckingServiceId:
                      onGoingTrip.acquiredTruckingServiceId.toString(),
                  tripId: onGoingTrip.tripId.toString(),
                  latitude: position.latitude,
                  longitude: position.longitude,
                );
              });
            }
            count = 0;
          }
          int duration = hasOnGoingTrip ? 5 : 20;
          if (sendDriverLocCount % duration == 0) {
            Driver driver = Get.find<DriverController>().driver.value;
            if (driver.driverId != null && driver.truckingCompanyId != null) {
              try {
                await driverService.sendDriverLatestLocation(
                  driverId: driver.driverId.toString(),
                  truckingCompanyId: driver.truckingCompanyId.toString(),
                  latitude: position.latitude,
                  longitude: position.longitude,
                );
              } catch (e) {
                inspect(e);
              }
            }
            sendDriverLocCount = 0;
          }
        }
        sendDriverLocCount++;
        count++;
      },
    );
  }

  /// Checks Permission of Driver App
  checkPermissions({isDisclosure = true}) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        checkPermissions(isDisclosure: isDisclosure);
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    if (isDisclosure) {
      Get.offAllNamed('/login');
      GetStorage().write('disclosure', true);
    }

    startLocationService();
  }

  addLocation({
    required double latitude,
    required double longitude,
    required String tripId,
    required String acquiredTruckingServiceId,
  }) async {
    coordinates.add({
      'entityId': "Mobile",
      'sourceId': "DriverApp",
      'date': DateTime.now().toUtc().toIso8601String(),
      'latitude': latitude,
      'longitude': longitude,
      'referenceNo': '$tripId-$acquiredTruckingServiceId',
    });
    var location = json.encode(coordinates);
    GetStorage().write('locations', location);
  }

  removeLocations() async {
    List<dynamic> locations = json.decode(
      GetStorage().read('locations'),
    );
    coordinates.clear();
    locations.clear();
    GetStorage().write('locations', null);
  }

  sendBulkLocation(List<dynamic> locations) {
    tripService.bulkAddTrackingHistory(listOfLocation: locations).then((value) {
      Get.find<TripScreenMapGoogleController>().startTrackAndTrace(1);
      removeLocations();
    }).catchError((error) {});
  }

  disposeListener() {
    positionStream!.cancel();
  }
}
