abstract class ITrip {
  Future<dynamic> getTripByStatus({
    required String driverId,
    required String status,
  });

  Future<dynamic> acceptTrip({
    required String driverId,
    required int acquiredTruckingServiceId,
  });

  Future<dynamic> getTripDetails({
    required int acquiredTruckingServiceId,
  });
}
