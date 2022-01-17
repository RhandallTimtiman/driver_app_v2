import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:get/get.dart';

class EmergencyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReasonController());
  }
}
