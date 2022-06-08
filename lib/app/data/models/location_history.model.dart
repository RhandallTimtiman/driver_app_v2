class LocationHistory {
  int originalIndex;
  String placeId;
  Location location;

  LocationHistory({
    required this.location,
    required this.originalIndex,
    required this.placeId,
  });

  factory LocationHistory.fromJson(Map<String, dynamic> json) {
    return LocationHistory(
      originalIndex: json['originalIndex'] as int,
      placeId: json['placeId'] as String,
      location: Location(
        latitude: json['location']['latitude'] is int
            ? (json['location']['latitude'] as int).toDouble()
            : json['location']['latitude'],
        longitude: json['location']['longitude'] is int
            ? (json['location']['longitude'] as int).toDouble()
            : json['location']['longitude'],
      ),
    );
  }
}

class Location {
  double latitude;
  double longitude;

  Location({required this.latitude, required this.longitude});
}
