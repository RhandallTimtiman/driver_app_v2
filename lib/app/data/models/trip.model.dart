import 'package:driver_app/app/data/models/models.dart';
import 'package:uuid/uuid.dart';

import 'company.model.dart';

class Trip {
  String id;
  int acquiredTruckingServiceId;
  String tripId;
  String jobOrderNo;
  int jobOrderId;
  DateTime deliveryDate;
  Company company;
  String routeName;
  int sequenceNo;
  bool isOrigin;
  OriginDestination origin;
  OriginDestination destination;
  int status;
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

  List<ContainerList> containerList;

  Trip({
    required this.id,
    required this.driverId,
    required this.tripId,
    required this.jobOrderNo,
    required this.jobOrderId,
    required this.company,
    required this.origin,
    required this.destination,
    required this.deliveryDate,
    required this.routeName,
    required this.statusId,
    required this.status,
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
        acquiredTruckingServiceId: json['acquiredTruckingServiceId'] as int,
        jobOrderNo: json['jobOrderNo'] as String,
        jobOrderId: json['jobOrderId'] as int,
        tripId: json['tripNo'] as String,
        routeName: json['route'] as String,
        sequenceNo: json['sequenceNo'] as int,
        isOrigin: json['isCurrentLocationOrigin'] ?? true,
        company: Company(
          id: json['shipperId'],
          address: json['company'],
          name: json['shipperName'],
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
        statusId: json['tripStatusId'] ? json['tripStatusId'] as String : '',
        statusDescription:
            json['tripStatusDesc'] ? json['tripStatusDesc'] as String : '',
        driverId: json['driverId'] as int,
        actualTimeArival: json['actualTimeArival'] != null
            ? DateTime.parse(json['actualTimeArival'] + "Z")
            : null,
        actualTimeDeparture: json['actualTimeDeparture'] != null
            ? DateTime.parse(json['actualTimeDeparture'] + "Z")
            : null,
        actualOriginLng:
            json['actualOriginLng'] ? json['actualOriginLng'] as String : '',
        actualOriginLat:
            json['actualOriginLat'] ? json['actualOriginLat'] as String : '',
        actualDestinationLat: json['actualDestinationLat']
            ? json['actualDestinationLat'] as String
            : '',
        actualDestinationLng: json['actualDestinationLng']
            ? json['actualDestinationLng'] as String
            : '',
        actualStart: json['actualStart'] != null
            ? DateTime.parse(json['actualStart'] + "Z")
            : null,
        actualStartLat:
            json['actualStartLat'] ? json['actualStartLat'] as String : '',
        actualStartLng:
            json['actualStartLng'] ? json['actualStartLng'] as String : '',
        containerList: json["containerList"] != null
            ? List<ContainerList>.from(
                json["containerList"].map(
                  (x) => ContainerList.fromJson(x),
                ),
              )
            : [],
        isReported: json['isReported'] ?? false,
        status: json['status']);
  }
}

class ContainerList {
  ContainerList({
    required this.jobOrderId,
    required this.truckingContainersId,
    required this.id,
    required this.containerNumber,
    required this.cargoWeight,
    required this.totalVolume,
    required this.specialCondition,
    required this.instructionsOthers,
  });

  int jobOrderId;
  int truckingContainersId;
  String id;
  String containerNumber;
  dynamic cargoWeight;
  String totalVolume;
  String specialCondition;
  String instructionsOthers;

  factory ContainerList.fromJson(Map<String, dynamic> json) => ContainerList(
        jobOrderId: json["jobOrderId"],
        truckingContainersId: json["truckingContainersId"],
        id: json["id"],
        containerNumber: json["containerNumber"],
        cargoWeight: json["cargoWeight"] ?? '',
        totalVolume: json["totalVolume"] ?? '',
        specialCondition: json["specialCondition"] ?? '',
        instructionsOthers: json["instructionsOthers"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "jobOrderId": jobOrderId,
        "truckingContainersId": truckingContainersId,
        "id": id,
        "containerNumber": containerNumber,
        "cargoWeight": cargoWeight,
        "totalVolume": totalVolume,
        "specialCondition": specialCondition,
        "instructionsOthers": instructionsOthers,
      };
}
