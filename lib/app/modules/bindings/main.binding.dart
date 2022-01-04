import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:get/get.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      ThemeController(),
      permanent: true,
    );
    Get.put(
      ConnectivityController(),
    );
    Get.put(
      DriverController(),
    );
    Get.put(
      VehicleController(),
    );
    Get.put(
      StatusController(),
    );
  }
}
