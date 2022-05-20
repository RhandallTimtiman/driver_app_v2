abstract class IRouteSimulation {
  /// Get Combined Trip Coordinates
  Future<dynamic> getTripHistoryGoogleCombinedLines({
    required String acquiredTruckingServiceId,
    required String tripId,
    required String companyId,
  });
}
