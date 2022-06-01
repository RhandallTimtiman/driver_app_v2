abstract class ICurrentTrip {
  /// Get Trip Summary Information
  Future<dynamic> getTripSummary({
    required int acquiredTruckingServiceId,
  });

  ///Get Trip By Trip Status (New, Pending, On Going, Complete)
  Future<dynamic> getTripByStatus({
    required int driverId,
    required String status,
  });

  ///Update Trip Actual Start
  Future<dynamic> updateActualStartTime({
    required int acquiredTruckingServiceId,
    required int driverId,
    required double lat,
    required double lng,
    required DateTime eta,
  });

  ///Update Trip's Actual Start
  Future<dynamic> getEstimatedRouteDistance({
    required double originLatitude,
    required double originLongitude,
    required double destinationLatitude,
    required double destinationLongitude,
  });

  ///Update Current Trip
  Future<dynamic> updateTrip({
    required int acquiredTruckingServiceId,
    required String status,
    required bool isOrigin,
  });

  ///Get List of Calling Code
  Future<dynamic> getCallingCodeList();

  ///Get List of Document Categories
  Future<dynamic> getDocumentCategories();
}
