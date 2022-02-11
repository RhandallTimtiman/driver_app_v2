import 'package:get/get.dart';

class OngoingTripController extends GetxController {
  RxBool hasOnGoingTrip = false.obs;

  void setHasOnGoingTrip(bool value) {
    hasOnGoingTrip.value = value;
  }
}
