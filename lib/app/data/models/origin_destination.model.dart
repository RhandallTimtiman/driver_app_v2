class OriginDestination {
  String address;
  double longitude;
  double latitude;
  String? instruction;
  int status;

  OriginDestination({
    this.address = '',
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.instruction = '',
    this.status = 0,
  });
}
