import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:get/get.dart';

class VehicleBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(() => VehicleController(), permanent: true);
  }
}
