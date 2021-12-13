import 'package:uuid/uuid.dart';
import 'models.dart';

class Trip {
  String id;
  int acquiredTruckingServiceId;
  String tripId;
  String jobOrderNo;
  int jobOrderId;
  DateTime deliveryDate;
  Company? company;
  String routeName;
  int sequenceNo;
  bool isOrigin;
  OriginDestination? origin;
  OriginDestination? destination;
  String statusId;
  String statusDescription;
  int driverId;
  DateTime? actualTimeDeparture;
  DateTime? actualTimeArival;
  String actualOriginLng;
  String actualOriginLat;
  String actualDestinationLat;
  String actualDestinationLng;
  DateTime? actualStart;
  String actualStartLat;
  String actualStartLng;
  bool isReported;
  List<ContainerList>? containerList;

  Trip({
    this.id = '',
    this.driverId = 0,
    this.tripId = '',
    this.jobOrderNo = '',
    this.jobOrderId = 0,
    this.company,
    this.origin,
    this.destination,
    required this.deliveryDate,
    this.routeName = '',
    this.statusId = '',
    this.sequenceNo = 0,
    this.statusDescription = '',
    this.isOrigin = true,
    this.acquiredTruckingServiceId = 0,
    this.actualDestinationLat = '',
    this.actualDestinationLng = '',
    this.actualOriginLat = '',
    this.actualOriginLng = '',
    this.actualTimeArival,
    this.actualTimeDeparture,
    this.actualStart,
    this.actualStartLat = '',
    this.actualStartLng = '',
    this.containerList,
    this.isReported = false,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
        id: const Uuid().v4(),
        acquiredTruckingServiceId: json['acquiredTruckingServiceId'] as int,
        jobOrderNo: json['jobOrderNo'] as String,
        jobOrderId: json['jobOrderId'] as int,
        tripId: json['tripNo'] as String,
        routeName: json['route'] as String,
        sequenceNo: json['sequenceNo'] as int,
        isOrigin: json['isCurrentLocationOrigin'] ?? true,
        company: Company(
          id: json['shipperId'] as String,
          address: json['company'] as String,
          name: json['shipperName'] as String,
        ),
        deliveryDate: DateTime.parse(json['scheduleStartDateTime']),
        origin: OriginDestination(
          address: json['originAddress'] as String,
          instruction: json['originRouteInstructions'] as String,
          longitude: double.parse(json['originLng']),
          latitude: double.parse(json['originLat']),
        ),
        destination: OriginDestination(
          address: json['destinationAddress'] as String,
          instruction: json['destinationRouteInstructions'] as String,
          longitude: double.parse(json['destinationLng']),
          latitude: double.parse(json['destinationLat']),
        ),
        statusId: json['tripStatusId'] as String,
        statusDescription: json['tripStatusDesc'] as String,
        driverId: json['driverId'] as int,
        actualTimeArival: json['actualTimeArival'] != null
            ? DateTime.parse(json['actualTimeArival'] + "Z")
            : null,
        actualTimeDeparture: json['actualTimeDeparture'] != null
            ? DateTime.parse(json['actualTimeDeparture'] + "Z")
            : null,
        actualOriginLng: json['actualOriginLng'] as String,
        actualOriginLat: json['actualOriginLat'] as String,
        actualDestinationLat: json['actualDestinationLat'] as String,
        actualDestinationLng: json['actualDestinationLng'] as String,
        actualStart: json['actualStart'] != null
            ? DateTime.parse(json['actualStart'] + "Z")
            : null,
        actualStartLat: json['actualStartLat'] as String,
        actualStartLng: json['actualStartLng'] as String,
        containerList: List<ContainerList>.from(
          json["containerList"].map(
            (x) => ContainerList.fromJson(x),
          ),
        ),
        isReported: json['isReported'] ?? false);
  }

  factory Trip.fromJson2(Map<String, dynamic> json) {
    return Trip(
        id: const Uuid().v4(),
        acquiredTruckingServiceId: json['AcquiredTruckingServiceId'] as int,
        jobOrderNo: json['JobOrderNo'] as String,
        jobOrderId: json['JobOrderId'] as int,
        tripId: json['TripNo'] as String,
        routeName: json['Route'] as String,
        sequenceNo: json['SequenceNo'] as int,
        isOrigin: json['IsCurrentLocationOrigin'] ?? true,
        company: Company(
          id: json['ShipperId'] as String,
          address: json['Company'] as String,
          name: json['ShipperName'] as String,
        ),
        deliveryDate: DateTime.parse(json['ScheduleStartDateTime']),
        origin: OriginDestination(
          address: json['OriginAddress'] as String,
          instruction: json['OriginRouteInstructions'] as String,
          longitude: double.parse(json['OriginLng']),
          latitude: double.parse(json['OriginLat']),
        ),
        destination: OriginDestination(
          address: json['DestinationAddress'] as String,
          instruction: json['DestinationRouteInstructions'] as String,
          longitude: double.parse(json['DestinationLng']),
          latitude: double.parse(json['DestinationLat']),
        ),
        statusId: json['TripStatusId'] as String,
        statusDescription: json['TripStatusDesc'] as String,
        driverId: json['DriverId'] as int,
        actualTimeArival: json['actualTimeArival'] != null
            ? DateTime.parse(json['actualTimeArival'] + "Z")
            : null,
        actualTimeDeparture: json['actualTimeDeparture'] != null
            ? DateTime.parse(json['actualTimeDeparture'] + "Z")
            : null,
        actualOriginLng: json['actualOriginLng'] as String,
        actualOriginLat: json['actualOriginLat'] as String,
        actualDestinationLat: json['actualDestinationLat'] as String,
        actualDestinationLng: json['actualDestinationLng'] as String,
        actualStart: json['actualStart'] != null
            ? DateTime.parse(json['actualStart'] + "Z")
            : null,
        actualStartLat: json['actualStartLat'] as String,
        actualStartLng: json['actualStartLng'] as String,
        containerList: List<ContainerList>.from(
            json["containerList"].map((x) => ContainerList.fromJson(x))),
        isReported: json['isReported'] ?? false);
  }
}
