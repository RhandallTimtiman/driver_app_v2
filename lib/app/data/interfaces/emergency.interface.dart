abstract class IEmergency {
  Future getReportIssueType();

  Future reportIssue({
    required String? reportIssueTypeId,
    required int acquiredTruckingServiceId,
    required String? remarks,
    required String driverId,
  });
}
