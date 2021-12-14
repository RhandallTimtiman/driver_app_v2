import 'package:driver_app/app/data/models/models.dart';
import 'package:get/get.dart';

class DriverController extends GetxController {
  final driver = Driver().obs;

  /// Assign new value of Driver
  setDriver(Driver value) {
    driver.value = value;
    update();
  }
}
