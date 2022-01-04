import 'package:driver_app/app/data/interfaces/interfaces.dart';
import 'package:driver_app/app/data/models/models.dart';
import 'package:driver_app/app/data/services/services.dart';
import 'package:get/get.dart';

class VehicleController extends GetxController {
  final vehicle = Vehicle().obs;

  final IVehicle _vehicleService = VehicleService();

  /// Get Vehicle Details
  Future<Vehicle> getVehicleDetails(driverId) =>
      _vehicleService.getVehicleDetails(driverId: driverId).then(
        (result) {
          var obj = Vehicle.fromJson(result);
          setVehicle(obj);
          return obj;
        },
      );

  /// Set Vehicle Details
  setVehicle(Vehicle value) {
    vehicle.value = value;
    update();
  }

  /// Get Chassis Details
  Future<Vehicle> getChassisDetails(driverId) =>
      _vehicleService.getChassisDetails(driverId: driverId).then(
        (result) {
          var obj = Vehicle.chassisFromJson(result);
          setVehicle(obj);
          return obj;
        },
      );
}
