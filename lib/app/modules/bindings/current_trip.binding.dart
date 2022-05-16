import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:get/get.dart';

class CurrentTripBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => CurrentTripController(),
    );
    Get.lazyPut(
      () => TripScreenMapGoogleController(),
    );
  }
}
