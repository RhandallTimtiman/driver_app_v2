import 'package:driver_app/app/data/interfaces/interfaces.dart';
import 'package:driver_app/app/data/models/models.dart';
import 'package:driver_app/app/data/services/services.dart';
import 'package:get/get.dart';

import 'controllers.dart';

class VehicleController extends GetxController {
  final vehicle = Vehicle().obs;
  final chassis = Chassis().obs;
  final temporaryChassis = Chassis().obs;
  final chassisList = <Chassis>[].obs;

  final IVehicle _vehicleService = VehicleService();

  @override
  void onInit() {
    super.onInit();
    getCurrentVehicle();
    getCurrentChassis();
    getChassisList();
  }

  /// Set Current Vehicle Details
  void setCurrentVehicle(Vehicle value) {
    vehicle.value = value;
    update();
  }

  /// Set Current Chassis Details
  void setCurrentChassis(Chassis value) {
    chassis.value = value;
    update();
  }

  /// Set List of Chassis
  void setChassisList(List<Chassis> value) {
    chassisList.value = value;
    update();
  }

  /// Temporary Chassis in Chassis Selection
  void setTemporaryChassis(Chassis value) {
    temporaryChassis.value = value;
    update();
  }

  /// Update Value of Current Chassis after selecting from Chassis Selection
  void updateCurrentChassis() {
    chassis.value = temporaryChassis.value;
    update();
  }

  /// Matches The Temporary Chassis to the Current Chassis
  void updateTemporaryChassis() {
    temporaryChassis.value = chassis.value;
    update();
  }

  /// Fetch Current Vehicle
  Future<void> getCurrentVehicle() async {
    var vehicleResult = await _vehicleService.getVehicleDetails(
      driverId: Get.find<DriverController>().driver.value.driverId.toString(),
    );
    setCurrentVehicle(vehicleResult);
  }

  /// Fetch Current Chassis
  Future<void> getCurrentChassis() async {
    var chassisResult = await _vehicleService.getChassisDetails(
      driverId: Get.find<DriverController>().driver.value.driverId.toString(),
    );
    setCurrentChassis(chassisResult);
    setTemporaryChassis(chassisResult);
  }

  /// Get Chassis List per company
  Future<void> getChassisList() async {
    var chassisListResult = await _vehicleService.getChassisByCompany(
      truckingCompanyId: Get.find<DriverController>()
          .driver
          .value
          .truckingCompanyId
          .toString(),
    );
    setChassisList(chassisListResult);
  }
}
