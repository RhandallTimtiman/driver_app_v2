import 'package:driver_app/app/data/models/models.dart';
import 'package:uuid/uuid.dart';

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
  OriginDestination origin;
  OriginDestination destination;
  String? statusId;
  String? statusDescription;
  int driverId;
  DateTime? actualTimeDeparture;
  DateTime? actualTimeArival;
  String? actualOriginLng;
  String? actualOriginLat;
  String? actualDestinationLat;
  String? actualDestinationLng;
  DateTime? actualStart;
  String? actualStartLat;
  String? actualStartLng;
  bool isReported;
  List<ContainerDetails> containerList;

  Trip({
    required this.id,
    required this.driverId,
    required this.tripId,
    required this.jobOrderNo,
    required this.jobOrderId,
    this.company,
    required this.origin,
    required this.destination,
    required this.deliveryDate,
    required this.routeName,
    required this.statusId,
    required this.sequenceNo,
    required this.statusDescription,
    this.isOrigin = true,
    required this.acquiredTruckingServiceId,
    this.actualDestinationLat = '',
    this.actualDestinationLng = '',
    this.actualOriginLat = '',
    this.actualOriginLng = '',
    required this.actualTimeArival,
    required this.actualTimeDeparture,
    required this.actualStart,
    this.actualStartLat = '',
    this.actualStartLng = '',
    required this.containerList,
    required this.isReported,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      id: const Uuid().v4(),
      acquiredTruckingServiceId: json['acquiredTruckingServiceId'],
      jobOrderNo: json['jobOrderNo'],
      jobOrderId: json['jobOrderId'],
      tripId: json['tripNo'],
      routeName: json['route'],
      sequenceNo: json['sequenceNo'],
      isOrigin: json['isCurrentLocationOrigin'] ?? true,
      company: Company(
        id: json['shipperId'],
        address: json['company'],
        name: json['shipperName'],
      ),
      deliveryDate: DateTime.parse(json['scheduleStartDateTime'] + 'Z'),
      origin: OriginDestination(
        address: json['originAddress'],
        instruction: json['originRouteInstructions'] ?? '',
        longitude: json['originLng'].toString().isEmpty
            ? 0.0
            : double.parse(json['originLng']),
        latitude: json['originLat'].toString().isEmpty
            ? 0.0
            : double.parse(json['originLat']),
      ),
      destination: OriginDestination(
        address: json['destinationAddress'],
        instruction: json['destinationRouteInstructions'],
        longitude: json['destinationLng'].toString().isEmpty
            ? 0.0
            : double.parse(json['destinationLng']),
        latitude: json['destinationLat'].toString().isEmpty
            ? 0.0
            : double.parse(json['destinationLat']),
      ),
      statusId: json['tripStatusId'],
      statusDescription: json['tripStatusDesc'],
      driverId: json['driverId'],
      actualTimeArival: json['actualTimeArival'] != null
          ? DateTime.parse(json['actualTimeArival'] + "Z")
          : null,
      actualTimeDeparture: json['actualTimeDeparture'] != null
          ? DateTime.parse(json['actualTimeDeparture'] + "Z")
          : null,
      actualOriginLng: json['actualOriginLng'],
      actualOriginLat: json['actualOriginLat'],
      actualDestinationLat: json['actualDestinationLat'],
      actualDestinationLng: json['actualDestinationLng'],
      actualStart: json['actualStart'] != null
          ? DateTime.parse(json['actualStart'] + "Z")
          : null,
      actualStartLat: json['actualStartLat'],
      actualStartLng: json['actualStartLng'],
      containerList: json["containerList"] != null
          ? List<ContainerDetails>.from(
              json["containerList"].map(
                (x) => ContainerDetails.fromJson(x),
              ),
            )
          : [],
      isReported: json['isReported'] ?? false,
    );
  }
}
