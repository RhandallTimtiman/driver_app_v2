import 'dart:async';
import 'package:driver_app/app/core/constants/strings.dart';
import 'package:driver_app/app/data/interfaces/interfaces.dart';
import 'package:driver_app/app/data/models/models.dart';
import 'package:driver_app/app/data/services/current_trip.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TripScreenMapGoogleController extends GetxController {
  final Completer<GoogleMapController> _controller = Completer();

  final ICurrentTrip _currentTripService = CurrentTripService();

  late BitmapDescriptor _currentLocationIconMarker;

  CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(12.8797, 121.7740),
    zoom: 0,
  );

  RxSet<Marker> markers = <Marker>{}.obs;

  late Marker? _currentMarker;

  late Marker _originMarker;

  late Marker _destinationMarker;

  late BitmapDescriptor _originIconMarker;

  late BitmapDescriptor _startIconMarker;

  late BitmapDescriptor _arrivedIconMarker;

  late BitmapDescriptor _endIconMarker;

  int counter = 0;

  Map<PolylineId, Polyline> polylines = {};

  PolylinePoints polylinePoints = PolylinePoints();

  List<LatLng> polylineCoordinates = [];

  StreamSubscription<Position>? positionStream;

  double? _finalBearing;

  @override
  void onInit() {
    var currentTrip = Get.find<CurrentTripController>().currentTrip.value;
    setMarkerIcon();
    getRouteDetails(
      originLat: currentTrip.trip.origin.latitude,
      originLng: currentTrip.trip.origin.longitude,
      destLat: currentTrip.trip.destination.latitude,
      destLng: currentTrip.trip.destination.longitude,
    );
    if (currentTrip.trip.statusId == 'ONG') {
      startTrackAndTrace(currentTrip.mapType);
    } else if (currentTrip.trip.statusId == 'COM') {
      getTripListHistoryGoogle();
    }
    super.onInit();
  }

  @override
  void dispose() {
    debugPrint('indispose');
    disposeMap();
    if (Get.find<CurrentTripController>().currentTrip.value.trip.statusId ==
        'ONG') {
      endTrackAndTrace();
    }
    super.dispose();
  }

  Widget showMap() {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: kGooglePlex,
      myLocationButtonEnabled: false,
      markers: markers,
      myLocationEnabled: false,
      zoomControlsEnabled: false,
      mapToolbarEnabled: false,
      polylines: Set<Polyline>.of(polylines.values),
      onMapCreated: (GoogleMapController controller) async {
        if (!_controller.isCompleted) {
          _controller.complete(controller);
        } else {}
        await goToCurrentLocation();
      },
    );
  }

  clearMarker(Marker marker, String id) {
    markers.removeWhere((Marker marker) => marker.markerId.value == id);
  }

  Future<void> goToCurrentLocation() async {
    GoogleMapController controller = await _controller.future;
    var resultQuery =
        markers.where((Marker marker) => marker.markerId.value == '0');
    if (resultQuery.isNotEmpty) {
      clearMarker(_currentMarker!, '0');
    }
    var currentLat = Get.find<LocationController>().currentLoc.value.latitude;
    var currentLng = Get.find<LocationController>().currentLoc.value.longitude;
    _currentMarker = Marker(
      markerId: const MarkerId('0'),
      position: LatLng(
        currentLat ?? 0.0,
        currentLng ?? 0.0,
      ),
      infoWindow: const InfoWindow(title: 'My Current Location'),
      icon: _currentLocationIconMarker,
    );

    addMarkers(_currentMarker);

    Get.find<CurrentTripController>()
        .updateCurrentLocation(currentLat ?? 0.0, currentLng ?? 0.0);

    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing:
              Get.find<LocationController>().currentLoc.value.heading ?? 0.0,
          target: LatLng(
            Get.find<LocationController>().currentLoc.value.latitude ?? 0.0,
            Get.find<LocationController>().currentLoc.value.longitude ?? 0.0,
          ),
          zoom: 12,
        ),
      ),
    );
    getAddressFromLatLng();
  }

  addMarkers(marker) {
    markers.add(marker);
    update();
  }

  setMarkerIcon() async {
    _currentLocationIconMarker = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      'assets/icons/current_location.png',
    );

    _originIconMarker = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      'assets/icons/dark_pin.png',
    );

    _startIconMarker = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      'assets/icons/start_pin.png',
    );

    _arrivedIconMarker = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      'assets/icons/arrived_pin.png',
    );

    _endIconMarker = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      'assets/icons/end_pin.png',
    );
  }

  getRouteDetails({
    dynamic originLat,
    dynamic originLng,
    dynamic destLat,
    dynamic destLng,
  }) async {
    Map<String, dynamic> northeastCoordinates;
    Map<String, dynamic> southwestCoordinates;

    var originRoute = {
      'latitude': originLat,
      'longitude': originLng,
    };

    var destinationRoute = {
      'latitude': destLat,
      'longitude': destLng,
    };
    debugPrint('===> in routeDetails');
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      Strings.gmapKey,
      PointLatLng(originLat, originLng),
      PointLatLng(destLat, destLng),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(
          LatLng(
            point.latitude,
            point.longitude,
          ),
        );
      }
    }
    if (originRoute['latitude'] <= destinationRoute['latitude']) {
      southwestCoordinates = originRoute;
      northeastCoordinates = destinationRoute;
    } else {
      southwestCoordinates = destinationRoute;
      northeastCoordinates = originRoute;
    }

    addPolyLine(
      isTraversed: false,
      polyLineId: 'polyline_id_$counter',
      coordinates: polylineCoordinates,
      color: Colors.grey,
    );

    counter++;

    zoomToOriginDestinationRoute(
      northeastCoordinates,
      southwestCoordinates,
    );

    _originMarker = Marker(
      markerId: const MarkerId('originMarker'),
      position: polylineCoordinates.first,
      infoWindow: const InfoWindow(title: 'Origin'),
      icon: _originIconMarker,
    );

    _destinationMarker = Marker(
      markerId: const MarkerId('destinationMarker'),
      position: polylineCoordinates.last,
      infoWindow: const InfoWindow(title: 'Destination'),
      icon: _originIconMarker,
    );

    markers.add(_originMarker);
    markers.add(_destinationMarker);

    update();
  }

  addPolyLine({
    required String polyLineId,
    bool isTraversed = false,
    dynamic coordinates,
    required Color color,
    bool isWaypoint = false,
  }) {
    PolylineId id = PolylineId('polyline_id_$counter');
    Polyline polyline = Polyline(
      polylineId: id,
      visible: true,
      color: color,
      // color: isTraversed ? Color.fromRGBO(0, 129, 174, 1) : Colors.grey,
      points: coordinates,
      width: 3,
      zIndex: isTraversed ? 6 : 5,
      patterns: !isTraversed
          ? [
              PatternItem.dash(8),
              PatternItem.gap(15),
            ]
          : [],
    );

    polylines[id] = polyline;

    counter++;
    update();
  }

  zoomToOriginDestinationRoute(
    northeastCoordinates,
    southwestCoordinates,
  ) async {
    GoogleMapController controller = await _controller.future;

    LatLngBounds bounds = LatLngBounds(
      northeast: LatLng(
        northeastCoordinates['latitude'],
        northeastCoordinates['longitude'],
      ),
      southwest: LatLng(
        southwestCoordinates['latitude'],
        southwestCoordinates['longitude'],
      ),
    );

    LatLng centerBounds = LatLng(
      (bounds.northeast.latitude + bounds.southwest.latitude) / 2,
      (bounds.northeast.longitude + bounds.southwest.longitude) / 2,
    );

    controller.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: centerBounds,
          zoom: 17,
        ),
      ),
    );
    zoomToFit(controller, bounds, centerBounds);
  }

  Future<void> zoomToFit(
    GoogleMapController controller,
    LatLngBounds bounds,
    LatLng centerBounds,
  ) async {
    bool keepZoomingOut = true;

    while (keepZoomingOut) {
      final LatLngBounds screenBounds = await controller.getVisibleRegion();
      if (fits(bounds, screenBounds)) {
        keepZoomingOut = false;
        final double zoomLevel = await controller.getZoomLevel() - 2.5;
        controller.moveCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: centerBounds,
              zoom: zoomLevel,
            ),
          ),
        );
        break;
      } else {
        final double zoomLevel = await controller.getZoomLevel() - 0.1;
        controller.moveCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: centerBounds,
              zoom: zoomLevel,
            ),
          ),
        );
      }
    }
  }

  bool fits(LatLngBounds fitBounds, LatLngBounds screenBounds) {
    final bool northEastLatitudeCheck =
        screenBounds.northeast.latitude >= fitBounds.northeast.latitude;
    final bool northEastLongitudeCheck =
        screenBounds.northeast.longitude >= fitBounds.northeast.longitude;

    final bool southWestLatitudeCheck =
        screenBounds.southwest.latitude <= fitBounds.southwest.latitude;
    final bool southWestLongitudeCheck =
        screenBounds.southwest.longitude <= fitBounds.southwest.longitude;

    return northEastLatitudeCheck &&
        northEastLongitudeCheck &&
        southWestLatitudeCheck &&
        southWestLongitudeCheck;
  }

  disposeMap() async {
    GoogleMapController controller = await _controller.future;
    controller.dispose();
    endTrackAndTrace();
  }

  getAddressFromLatLng() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(
        Get.find<LocationController>().currentLoc.value.latitude!,
        Get.find<LocationController>().currentLoc.value.longitude!,
      );
      Placemark place = p[0];
      var _currentAddress =
          "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";
      debugPrint(_currentAddress);
      Get.find<CurrentTripController>().updateCurrentAddress(_currentAddress);
    } catch (e) {
      rethrow;
    }
  }

  plotMarkers() {
    int mapType = Get.find<CurrentTripController>().currentTrip.value.mapType;
    if (mapType == 1) {
      getTripListHistoryGoogle();
    }
  }

  startTrackAndTrace(mapType) {
    int count = 0;
    positionStream = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    )).listen((Position? position) {
      if (mapType == 1) {
        movePin(position, _finalBearing ?? 0.0);

        if (count % 5 == 0) {
          count = 0;
          movePin(position, _finalBearing ?? 0.0);
        }
      }
    });
    count++;
  }

  movePin(
    dynamic position,
    double bearing,
  ) async {
    GoogleMapController controller = await _controller.future;

    if (_currentMarker != null) {
      clearMarker(_currentMarker!, '0');
    }

    _currentMarker = Marker(
      markerId: const MarkerId('0'),
      position: LatLng(position.latitude, position.longitude),
      infoWindow: const InfoWindow(title: 'My Current Location'),
      icon: _currentLocationIconMarker,
    );

    markers.add(_currentMarker!);
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          bearing: bearing,
          target: LatLng(
            position.latitude,
            position.longitude,
          ),
          zoom: 19,
          tilt: 60,
        ),
      ),
    );
    getAddressFromLatLng();
  }

  endTrackAndTrace() {
    if (positionStream != null) {
      positionStream!.cancel();
    }
  }

  getTripListHistoryGoogle() {
    List<LatLng> polyCoordinatesFixed = [];
    List<LatLng> polyCoordinatesRouted = [];
    Trip trip = Get.find<CurrentTripController>().currentTrip.value.trip;

    _currentTripService
        .getTripHistoryGoogle(
      acquiredTruckingServiceId: trip.acquiredTruckingServiceId.toString(),
      tripId: trip.tripId,
      companyId: Get.find<DriverController>().driver.value.truckingCompanyId!,
    )
        .then((lines) async {
      PlottingLines plotLines = lines;
      await Future.forEach(plotLines.tripLines,
          (dynamic tripLineCoordinate) async {
        int i = 1;
        polyCoordinatesFixed = [];
        if (tripLineCoordinate.length != 0) {
          await Future.forEach(tripLineCoordinate, (_) {
            List<String> coordinates = _.toString().split(',');
            polyCoordinatesFixed.add(
              LatLng(
                double.parse(coordinates[0]),
                double.parse(coordinates[1]),
              ),
            );
          });
          addStraightPolyline(
            polyLineId: 'fixed_$i',
            isTraversed: true,
            coordinates: polyCoordinatesFixed,
          );
          i++;
        }
      });
      int i = 1;
      await Future.forEach(lines.routeLines, (dynamic routeCoordinates) async {
        polyCoordinatesRouted = [];
        if (routeCoordinates.length != 0) {
          await Future.forEach(routeCoordinates, (_) {
            List<String> res = _.toString().split(',');
            polyCoordinatesRouted.add(
              LatLng(
                double.parse(res[0]),
                double.parse(res[1]),
              ),
            );
          });
          addPolyLine(
            polyLineId: 'routed_$i',
            isTraversed: false,
            coordinates: polyCoordinatesRouted,
            color: const Color.fromRGBO(0, 129, 174, 1),
            isWaypoint: false,
          );
          i++;
        }
      });

      addRouteMarker(
        legend: 1,
        latitude: double.parse(lines.start.split(',')[0]),
        longitude: double.parse(lines.start.split(',')[1]),
      );

      if (trip.actualOriginLat != null) {
        addRouteMarker(
          legend: 2,
          latitude: double.parse(trip.actualOriginLat!),
          longitude: double.parse(trip.actualOriginLng!),
        );
      }

      if (trip.statusId == 'COM') {
        addRouteMarker(
          legend: 3,
          latitude: double.parse(lines.end.split(',')[0]),
          longitude: double.parse(lines.end.split(',')[1]),
        );
      }
      Map<String, dynamic> northeastCoordinates = {
        'latitude': double.parse(lines.bounds.northEast.split(',')[0]),
        'longitude': double.parse(lines.bounds.northEast.split(',')[1]),
      };
      Map<String, dynamic> southwestCoordinates = {
        'latitude': double.parse(lines.bounds.southWest.split(',')[0]),
        'longitude': double.parse(lines.bounds.southWest.split(',')[1]),
      };

      zoomToOriginDestinationRoute(
        northeastCoordinates,
        southwestCoordinates,
      );
    });
  }

  addStraightPolyline({
    required String polyLineId,
    bool isTraversed = false,
    dynamic coordinates,
    bool isWaypoint = false,
  }) {
    PolylineId id = PolylineId('polyline_id_$counter');
    Polyline polyline = Polyline(
      polylineId: id,
      visible: true,
      color: isTraversed ? const Color.fromRGBO(0, 129, 174, 1) : Colors.grey,
      points: coordinates,
      width: 3,
      zIndex: isTraversed ? 6 : 5,
    );
    polylines[id] = polyline;
    counter++;
  }

  addPolyline({
    required String polyLineId,
    bool isTraversed = false,
    dynamic coordinates,
    required Color color,
    bool isWaypoint = false,
  }) {
    PolylineId id = PolylineId('polyline_id_$counter');
    Polyline polyline = Polyline(
      polylineId: id,
      visible: true,
      color: color,
      points: coordinates,
      width: 3,
      zIndex: isTraversed ? 6 : 5,
      patterns: !isTraversed
          ? [
              PatternItem.dash(8),
              PatternItem.gap(15),
            ]
          : [],
    );
    polylines[id] = polyline;

    counter++;
  }

  addRouteMarker({
    required int legend,
    required double latitude,
    required double longitude,
  }) {
    late BitmapDescriptor iconMarker;
    switch (legend) {
      case 1:
        iconMarker = _startIconMarker;
        break;
      case 2:
        iconMarker = _arrivedIconMarker;
        break;
      case 3:
        iconMarker = _endIconMarker;
        break;
      default:
    }

    markers.add(
      Marker(
        markerId: MarkerId(
          legend.toString(),
        ),
        position: LatLng(latitude, longitude),
        icon: iconMarker,
      ),
    );
  }
}
