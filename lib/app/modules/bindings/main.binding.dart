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
      permanent: true,
    );
    Get.put(
      AuthController(),
    );
    Get.put(
      DriverController(),
    );
  }
}
