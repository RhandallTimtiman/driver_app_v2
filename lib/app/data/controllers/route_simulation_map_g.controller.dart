import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RouteSimulationMapGoogleController extends GetxController {
  final Completer<GoogleMapController> _controller = Completer();

  late BitmapDescriptor _currentLocationIconMarker;

  final LocationController locationController = Get.put(LocationController());

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(12.8797, 121.7740),
    zoom: 0,
  );

  RxSet<Marker> markers = <Marker>{}.obs;

  late Marker _currentMarker;

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

  final String gmapApiKey = 'AIzaSyDnC23xX9YyLwYIbdx4nkegfRH6LTIrcP0';
  @override
  void onInit() {
    setMarkerIcon();
    super.onInit();
  }

  Widget showMap() {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _kGooglePlex,
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
    if (markers.isNotEmpty) {
      markers.removeWhere(
        (Marker marker) => marker.markerId.value == id,
      );
    }
  }

  removeOriginAndDestinationMarker() {
    markers.removeWhere((Marker marker) => marker.markerId.value == '1');
    markers.removeWhere((Marker marker) => marker.markerId.value == '3');
  }

  Future<void> goToCurrentLocation() async {
    GoogleMapController controller = await _controller.future;

    var resultQuery =
        markers.where((Marker marker) => marker.markerId.value == '0');

    if (resultQuery.isNotEmpty) {
      clearMarker(_currentMarker, '0');
    }

    _currentMarker = Marker(
      markerId: const MarkerId('0'),
      position: LatLng(
        Get.find<LocationController>().currentLoc.value.latitude ?? 0.0,
        Get.find<LocationController>().currentLoc.value.longitude ?? 0.0,
      ),
      infoWindow: const InfoWindow(title: 'My Current Location'),
      icon: _currentLocationIconMarker,
    );

    addMarkers(_currentMarker);

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

  addStraightPolyLineSimulation({
    required String polyLineId,
    bool isTraversed = false,
    dynamic coordinates,
  }) {
    PolylineId id = PolylineId(polyLineId);
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
    update();
  }

  Future moveCamera({dynamic lat, dynamic lng}) async {
    GoogleMapController controller = await _controller.future;

    await controller.moveCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            lat,
            lng,
          ),
          zoom: 15,
        ),
      ),
    );
  }

  addRouteSimulationMarker({
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

  movePinPlayRoute({
    required double latitude,
    required double longitude,
  }) async {
    clearMarker(_currentMarker, '0');

    _currentMarker = Marker(
      markerId: const MarkerId('0'),
      position: LatLng(latitude, longitude),
      infoWindow: const InfoWindow(title: 'My Current Location'),
      icon: _currentLocationIconMarker,
    );

    markers.add(_currentMarker);
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

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      gmapApiKey,
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
  }
}
