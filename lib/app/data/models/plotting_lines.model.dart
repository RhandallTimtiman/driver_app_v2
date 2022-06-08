class PlottingLines {
  String referenceNo;
  int coordinatesCount;
  List<dynamic> tripLines;
  List<dynamic> jumpingLines;
  List<dynamic> routeLines;
  String start;
  String end;
  Bounds bounds;

  PlottingLines({
    required this.referenceNo,
    required this.coordinatesCount,
    required this.tripLines,
    required this.jumpingLines,
    required this.routeLines,
    required this.start,
    required this.end,
    required this.bounds,
  });

  factory PlottingLines.fromJson(Map<String, dynamic> json) {
    return PlottingLines(
      referenceNo: json['referenceNo'] as String,
      coordinatesCount: json['coordinatesCount'] as int,
      tripLines: json['tripLines'],
      jumpingLines: json['jumpingLines'],
      routeLines: json['routeLines'],
      start: json['start'] as String,
      end: json['end'] as String,
      bounds: Bounds(
        northEast: json['bounds']['northEast'],
        southWest: json['bounds']['southWest'],
      ),
    );
  }
}

class Bounds {
  String northEast;
  String southWest;

  Bounds({
    required this.northEast,
    required this.southWest,
  });
}
