abstract class ISettings {
  Future changePin({
    int? driverId,
    required String oldPin,
    required String newPin,
  });
}
