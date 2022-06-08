import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:get/get.dart';

class RouteSimulationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => RouteSimulationController(),
    );
    Get.lazyPut(
      () => RouteSimulationMapGoogleController(),
    );
  }
}
