import 'dart:convert';

import 'package:driver_app/app/data/models/models.dart';

TripSummaryModel tripSummaryFromJson(String str) =>
    TripSummaryModel.fromJson(json.decode(str));

String tripSummaryToJson(TripSummaryModel data) => json.encode(data.toJson());

class TripSummaryModel {
  int driverId;
  int vehicleId;
  String plateNumber;
  String brand;
  String model;
  int year;
  String type;
  int acquiredTruckingServiceId;
  String tripNo;
  String originAddress;
  String originStateCityName;
  String originRouteInstructions;
  String originLng;
  String originLat;
  String destinationAddress;
  String destinationStateCityName;
  String destinationRouteInstructions;
  String destinationLat;
  String destinationLng;
  DateTime? actualTimeDeparture;
  DateTime? actualTimeArival;
  DateTime? actualStart;
  String? actualStartLat;
  String? actualStartLng;
  String tripStatusId;
  String tripStatusDescription;
  DateTime? scheduleStartDateTime;
  DateTime? scheduleEndDateTime;
  String bookingPartyId;
  String bookingPartyName;
  List<TripDocument> tripDocuments;
  List<ContainerInfoList> containerInfoList;

  TripSummaryModel({
    required this.driverId,
    required this.vehicleId,
    required this.plateNumber,
    required this.brand,
    required this.model,
    required this.year,
    required this.type,
    required this.acquiredTruckingServiceId,
    required this.tripNo,
    required this.originAddress,
    required this.originStateCityName,
    required this.originRouteInstructions,
    required this.originLng,
    required this.originLat,
    required this.destinationAddress,
    required this.destinationStateCityName,
    required this.destinationRouteInstructions,
    required this.destinationLat,
    required this.destinationLng,
    this.actualTimeDeparture,
    this.actualTimeArival,
    this.actualStart,
    this.actualStartLat,
    this.actualStartLng,
    required this.tripStatusId,
    required this.tripStatusDescription,
    required this.scheduleStartDateTime,
    required this.scheduleEndDateTime,
    required this.bookingPartyId,
    required this.bookingPartyName,
    required this.tripDocuments,
    required this.containerInfoList,
  });

  factory TripSummaryModel.fromJson(Map<String, dynamic> json) =>
      TripSummaryModel(
        driverId: json["driverId"],
        vehicleId: json["vehicleId"],
        plateNumber: json["plateNumber"],
        brand: json["brand"],
        model: json["model"],
        year: json["year"],
        type: json["type"],
        acquiredTruckingServiceId: json["acquiredTruckingServiceId"],
        tripNo: json["tripNo"],
        originAddress: json["originAddress"],
        originStateCityName: json["originStateCityName"],
        originRouteInstructions: json["originRouteInstructions"],
        originLng: json["originLng"],
        originLat: json["originLat"],
        destinationAddress: json["destinationAddress"],
        destinationStateCityName: json["destinationStateCityName"],
        destinationRouteInstructions: json["destinationRouteInstructions"],
        destinationLat: json["destinationLat"],
        destinationLng: json["destinationLng"],
        tripDocuments: List<TripDocument>.from(
            json["tripDocuments"].map((x) => TripDocument.fromJson(x))),
        tripStatusId: json["tripStatusId"],
        actualTimeArival: json['actualTimeArival'] != null
            ? DateTime.parse(json['actualTimeArival'] + "Z")
            : null,
        actualTimeDeparture: json['actualTimeDeparture'] != null
            ? DateTime.parse(json['actualTimeDeparture'] + "Z")
            : null,
        actualStart: json['actualStart'] != null
            ? DateTime.parse(json['actualStart'] + "Z")
            : null,
        scheduleStartDateTime: json["scheduleStartDateTime"] != null
            ? DateTime.parse(json["scheduleStartDateTime"])
            : null,
        scheduleEndDateTime: json["scheduleEndDateTime"] != null
            ? DateTime.parse(json["scheduleEndDateTime"])
            : null,
        actualStartLat: json["actualStartLat"] ?? '',
        actualStartLng: json["actualStartLng"] ?? '',
        tripStatusDescription: json["tripStatusDescription"],
        bookingPartyId: json["bookingPartyId"],
        bookingPartyName: json["bookingPartyName"],
        containerInfoList: List<ContainerInfoList>.from(
            json["containerInfoList"]
                .map((x) => ContainerInfoList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "driverId": driverId,
        "vehicleId": vehicleId,
        "plateNumber": plateNumber,
        "brand": brand,
        "model": model,
        "year": year,
        "type": type,
        "acquiredTruckingServiceId": acquiredTruckingServiceId,
        "tripNo": tripNo,
        "originAddress": originAddress,
        "originStateCityName": originStateCityName,
        "originRouteInstructions": originRouteInstructions,
        "originLng": originLng,
        "originLat": originLat,
        "destinationAddress": destinationAddress,
        "destinationStateCityName": destinationStateCityName,
        "destinationRouteInstructions": destinationRouteInstructions,
        "destinationLat": destinationLat,
        "destinationLng": destinationLng,
        "actualTimeDeparture": actualTimeDeparture?.toIso8601String(),
        "actualTimeArival": actualTimeArival?.toIso8601String(),
        "actualStart": actualStart?.toIso8601String(),
        "actualStartLat": actualStartLat,
        "actualStartLng": actualStartLng,
        "tripStatusId": tripStatusId,
        "tripStatusDescription": tripStatusDescription,
        "scheduleStartDateTime": scheduleStartDateTime?.toIso8601String(),
        "scheduleEndDateTime": scheduleEndDateTime?.toIso8601String(),
        "bookingPartyId": bookingPartyId,
        "bookingPartyName": bookingPartyName,
        "tripDocuments":
            List<dynamic>.from(tripDocuments.map((x) => x.toJson())),
        "containerInfoList":
            List<dynamic>.from(containerInfoList.map((x) => x.toJson())),
      };
}
