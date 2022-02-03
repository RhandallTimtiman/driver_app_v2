import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:get/get.dart';

class NewTripBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NewTripsController());
  }
}
