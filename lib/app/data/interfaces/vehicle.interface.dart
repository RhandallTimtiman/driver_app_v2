abstract class IVehicle {
  Future getVehicleDetails({required String driverId});
  Future getChassisDetails({required String driverId});
  Future getChassisByCompany({required String truckingCompanyId});
}
