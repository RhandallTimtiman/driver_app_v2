class CurrentPosition {
  final double? latitude;
  final double? longitude;
  final double? accuracy;
  final double? verticalAccuracy;
  final double? altitude;
  final double? speed;
  final double? speedAccuracy;
  final double? heading;
  final double? time;
  final bool? isMock;
  final double? headingAccuracy;
  final double? elapsedRealtimeNanos;
  final double? elapsedRealtimeUncertaintyNanos;
  final int? satelliteNumber;
  final String? provider;

  CurrentPosition({
    this.latitude,
    this.longitude,
    this.accuracy,
    this.altitude,
    this.speed,
    this.speedAccuracy,
    this.heading,
    this.time,
    this.isMock,
    this.verticalAccuracy,
    this.headingAccuracy,
    this.elapsedRealtimeNanos,
    this.elapsedRealtimeUncertaintyNanos,
    this.satelliteNumber,
    this.provider,
  });
}
