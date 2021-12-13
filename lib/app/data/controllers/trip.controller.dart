import 'package:driver_app/app/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TripController extends GetxController {
  static TripController to = Get.find();

  List<Trip> tripList = [];

  TextEditingController searchController = TextEditingController();

  setTripList(List<Trip> list) {
    tripList = list;
    update();
  }

  addTrip(Trip tr) {
    tripList.add(tr);
    update();
  }

  clearTrips() {
    tripList.clear();
    update();
  }
}
