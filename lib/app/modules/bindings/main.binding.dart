import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:get/get.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      NotificationController(),
      permanent: true,
    );
    Get.put(
      LocationController(),
      permanent: true,
    );
    Get.put(
      DriverController(),
    );
    Get.put(
      SessionController(),
      permanent: true,
    );
    Get.put(
      ThemeController(),
      permanent: true,
    );
    Get.put(
      ConnectivityController(),
    );
    Get.put(
      StatusController(),
    );
    Get.put(
      OngoingTripController(),
    );
    Get.put(
      TripController(),
      permanent: true,
    );
    Get.put(
      CurrentTripController(),
      permanent: true,
    );
  }
}
