abstract class ICurrentTrip {
  /// Get Trip Summary Information
  Future<dynamic> getTripSummary({
    required int acquiredTruckingServiceId,
  });

  /// Get Combined Trip Coordinates
  Future<dynamic> getTripHistoryGoogleCombinedLines({
    required String acquiredTruckingServiceId,
    required String tripId,
    required String companyId,
  });
}
