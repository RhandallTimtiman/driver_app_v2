import 'package:driver_app/app/data/models/models.dart';

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

  /// Upload Route Completion Documents
  Future<dynamic> uploadRouteCompletionDocuments({
    required int acquiredTruckingServiceId,
    required String receivedBy,
    required String contactNo,
    required List<DocumentModel> documents,
    required List<Map> containerList,
    required bool isOrigin,
    required DateTime etd,
  });

  /// Add Tracking History
  Future<dynamic> addTrackingHistory({
    required String acquiredTruckingServiceId,
    required String tripId,
    required double latitude,
    required double longitude,
  });

  Future<dynamic> updateCurrentLatLng({
    required String acquiredTruckingServiceId,
    required double latitude,
    required double longitude,
    required bool isOrigin,
    required String dateUploaded,
  });

  Future<dynamic> getNextTrip({
    required int driverId,
    required int jobOrderId,
    required int sequenceNo,
  });

  Future<dynamic> getTripHistoryGoogle({
    required String acquiredTruckingServiceId,
    required String tripId,
    required String companyId,
  });
}
