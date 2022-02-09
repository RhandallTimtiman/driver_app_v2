import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:get/instance_manager.dart';

class TodayTripsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => TodayTripsController(),
    );
  }
}
