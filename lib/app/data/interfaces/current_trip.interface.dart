abstract class ICurrentTrip {
  /// Get Trip Summary Information
  Future<dynamic> getTripSummary({
    required int acquiredTruckingServiceId,
  });
}
