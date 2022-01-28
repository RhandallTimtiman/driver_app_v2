abstract class ITrip {
  Future<dynamic> getTripByStatus(
      {required String driverId, required String status});
  Future getGoogleMapTrip();
}
