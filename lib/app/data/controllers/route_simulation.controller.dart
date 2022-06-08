import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/data/interfaces/interfaces.dart';
import 'package:driver_app/app/data/models/models.dart';
import 'package:driver_app/app/data/services/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteSimulationController extends GetxController {
  static RouteSimulationController to = Get.find();

  final RouteSimulationMapGoogleController _routeSimulationMapGoogleController =
      Get.find();

  final currentTrip = CurrentState().obs;

  List<dynamic> combinedLines = [];

  final IRouteSimulation routeService = RouteSimulationService();

  double totalDistance = 0.0;

  Set<Marker> markers = HashSet<Marker>();

  List<LatLng> polyLines = [];

  bool isOnStart = false;

  bool isPaused = false;

  int index = 0;

  int counter = 0;

  late Timer timer;

  @override
  void onInit() {
    setSelectedTrip(Get.find<TripController>().state.value.trip);
    getCombinedLines();
    googleGetRouteDetails();
    super.onInit();
  }

  void setSelectedTrip(Trip trip) {
    currentTrip.value.trip = trip;
    update();
  }

  getCombinedLines() {
    Trip trip = currentTrip.value.trip;
    routeService
        .getTripHistoryGoogleCombinedLines(
      acquiredTruckingServiceId: trip.acquiredTruckingServiceId.toString(),
      tripId: trip.tripId,
      companyId: Get.find<DriverController>()
          .driver
          .value
          .truckingCompanyId
          .toString(),
    )
        .then(
      (value) {
        combinedLines = value;
        for (var i = 0; i < value.length - 1; i++) {
          try {
            var pointA = value[i];
            var pointB = value[i + 1];

            List<String> resA = pointA.split(',');
            List<String> resB = pointB.split(',');

            totalDistance += calculateDistance(
              double.parse(resA[0]),
              double.parse(resA[1]),
              double.parse(resB[0]),
              double.parse(resB[1]),
            );
            update();
          } catch (e) {
            rethrow;
          }
        }
      },
    );
  }

  playRoute() async {
    double sectionedTime = 10000;
    int totalLines = combinedLines.length;
    var optionLine = 0;

    _routeSimulationMapGoogleController.removeOriginAndDestinationMarker();
    optionLine = totalLines;

    if (totalDistance > 60) {
      sectionedTime = (totalDistance / 60.0) * 10000.0;
    }

    int totalMilli = (sectionedTime ~/ optionLine).toInt();

    var milliSecs = Duration(milliseconds: totalMilli);

    {
      List<String> res = combinedLines[index].toString().split(',');
      await _routeSimulationMapGoogleController.moveCamera(
        lat: double.parse(res[0]),
        lng: double.parse(
          res[1],
        ),
      );
    }

    Timer(
      const Duration(milliseconds: 1000),
      () {
        try {
          if (isOnStart) {
            polyLines.clear();
          }
          timer = Timer.periodic(
            milliSecs,
            (Timer t) {
              if (index != totalLines) {
                List<String> res = combinedLines[index].toString().split(',');
                polyLines.add(
                  LatLng(
                    double.parse(res[0]),
                    double.parse(res[1]),
                  ),
                );
                if (index == 0) {
                  _routeSimulationMapGoogleController.addRouteSimulationMarker(
                    latitude: double.parse(res[0]),
                    longitude: double.parse(res[1]),
                    legend: 1,
                  );
                }

                _routeSimulationMapGoogleController
                    .addStraightPolyLineSimulation(
                  polyLineId: 'SimulatedRoute',
                  isTraversed: true,
                  coordinates: polyLines,
                );
                _routeSimulationMapGoogleController.movePinPlayRoute(
                  latitude: double.parse(res[0]),
                  longitude: double.parse(res[1]),
                );
                _routeSimulationMapGoogleController.moveCamera(
                  lat: double.parse(res[0]),
                  lng: double.parse(res[1]),
                );
                if (index == totalLines - 1) {
                  _routeSimulationMapGoogleController.addRouteSimulationMarker(
                    latitude: double.parse(res[0]),
                    longitude: double.parse(res[1]),
                    legend: 3,
                  );
                }
                index++;
                update();
              } else {
                isOnStart = true;
                isPaused = false;
                t.cancel();
              }
            },
          );
        } catch (e) {
          rethrow;
        }
      },
    );
    isPaused = !isPaused;
  }

  googleGetRouteDetails() async {
    Trip trip = currentTrip.value.trip;
    _routeSimulationMapGoogleController.getRouteDetails(
      originLat: trip.origin.latitude,
      originLng: trip.origin.longitude,
      destLat: trip.destination.latitude,
      destLng: trip.destination.longitude,
    );
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  updateIndex(value) {
    index = value;
    update();
  }

  pauseRouteSimulation() {
    isOnStart = false;
    isPaused = false;

    timer.cancel();
    update();
  }
}
