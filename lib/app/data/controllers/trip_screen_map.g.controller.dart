import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TripScreenMapGoogleController extends GetxController {
  final Completer<GoogleMapController> _controller = Completer();

  late BitmapDescriptor _currentLocationIconMarker;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(12.8797, 121.7740),
    zoom: 0,
  );

  RxSet<Marker> markers = <Marker>{}.obs;

  late Marker _currentMarker;

  @override
  void onInit() {
    setMarkers();
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

  void setMarkers() async {
    _currentLocationIconMarker =
        _currentLocationIconMarker = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      'assets/icons/current_location.png',
    );
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
}
