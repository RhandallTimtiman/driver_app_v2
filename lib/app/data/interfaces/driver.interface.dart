abstract class IDriver {
  Future<dynamic> sendDriverLatestLocation({
    required String driverId,
    required String truckingCompanyId,
    required double latitude,
    required double longitude,
  });
}
