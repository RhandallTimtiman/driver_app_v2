abstract class IStatus {
  Future updateDriverOnlineStatus({
    int? driverId,
    bool? onlineStatus,
    double? latestLat = 0.0,
    double? latestLng = 0.0,
  });
}
