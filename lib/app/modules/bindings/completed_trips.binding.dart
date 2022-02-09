import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:get/instance_manager.dart';

class CompletedTripsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => CompletedTripsController(),
    );
  }
}
