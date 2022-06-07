abstract class ITrip {
  /// Get Trips By Status
  Future<dynamic> getTripByStatus({
    required String driverId,
    required String status,
  });

  /// Accepts Trip
  Future<dynamic> acceptTrip({
    required String driverId,
    required int acquiredTruckingServiceId,
  });

  /// Get Trip Information
  Future<dynamic> getTripDetails({
    required int acquiredTruckingServiceId,
  });

  /// Accepts All Trip
  Future<dynamic> acceptAllTrip({
    required List<Map<String, dynamic>> trips,
    required int driverId,
  });

  /// Get New Trip Information
  Future getNewTrip({
    required int driverId,
    required int jobOrder,
  });

  /// Reject Selected Trip
  Future rejectSelectedTrip({
    required int acquiredTruckingServiceId,
    required String remarks,
    required String reasonOfRejectionId,
  });

  ///List of Reason of Rejection
  Future getListOfReasonOfRejection();
}
