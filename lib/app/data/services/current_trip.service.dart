import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:driver_app/app/core/constants/api_paths.dart';
import 'package:driver_app/app/core/constants/strings.dart';
import 'package:driver_app/app/core/utils/database.helper.dart';
import 'package:driver_app/app/data/interceptors/api.interceptor.dart';
import 'package:driver_app/app/data/interfaces/interfaces.dart';
import 'package:driver_app/app/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

class CurrentTripService implements ICurrentTrip {
  final _dio = Dio()..interceptors.add(ApiInterceptor());
  final dbHelper = DatabaseHelper.instance;

  @override
  Future getTripSummary({required int acquiredTruckingServiceId}) async {
    _dio.options.headers = <String, dynamic>{
      "requiresToken": true,
    };

    try {
      String unencodedPath = '/oat/api/driver-app/TripSummary';

      var queryParameters = {
        'acquiredTruckingServiceId': acquiredTruckingServiceId.toString()
      };
      var uri = Uri.https(ApiPaths.proxy, unencodedPath, queryParameters);

      Response response = await _dio.getUri(uri);

      if (response.statusCode == 200) {
        ApiResponse parsedResponse = ApiResponse.fromJson(
          response.data,
        );
        if (parsedResponse.data != null) {
          TripSummaryModel tripSummary =
              TripSummaryModel.fromJson(parsedResponse.data);
          return tripSummary;
        } else {
          throw parsedResponse;
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future getTripByStatus(
      {required int driverId, required String status}) async {
    _dio.options.headers = <String, dynamic>{
      'requiresToken': true,
    };
    try {
      var queryParameters = {
        'driverId': driverId.toString(),
        'status': status == 'All' ? [] : status.split(',')
      };
      String unencodedPath = status == 'TODAY'
          ? '/oat/api/driver-app/TodaysTrip'
          : '/oat/api/driver-app/GetTripsPerDriver';

      Uri uri;
      Response response;
      if (status == 'TODAY') {
        uri = Uri.https(ApiPaths.proxy, unencodedPath, queryParameters);
        response = await _dio.getUri(uri);
      } else {
        uri = Uri.https(ApiPaths.proxy, unencodedPath);
        response = await _dio.postUri(uri, data: queryParameters);
      }

      if (response.statusCode == 200) {
        ApiResponse parsedResponse = ApiResponse.fromJson(
          response.data,
        );
        if (parsedResponse.data != null) {
          List<Trip> trips = parsedResponse.data
              .map<Trip>((item) => Trip.fromJson(item))
              .toList();
          return trips;
        } else {
          throw parsedResponse;
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future updateActualStartTime({
    required int acquiredTruckingServiceId,
    required int driverId,
    required double lat,
    required double lng,
    required DateTime eta,
  }) async {
    _dio.options.headers = <String, dynamic>{
      "requiresToken": true,
    };

    try {
      String unencodedPath = '/oat/api/driver-app/UpdateActualStart';

      var queryParameters = {
        'AcquiredTruckingServiceId': acquiredTruckingServiceId.toString(),
        'ActualStartLat': lat.toString(),
        'ActualStartLng': lng.toString(),
        'EstimatedDateTimeDeparture': eta.toString(),
        'driverId': driverId.toString()
      };

      var uri = Uri.https(ApiPaths.proxy, unencodedPath, queryParameters);
      Response response = await _dio.postUri(uri);
      debugPrint(response.data['message']);
      if (response.statusCode == 200) {
        if (response.data['data'] != null) {
          ApiResponse parsedResponse = ApiResponse.fromJson(
            response.data,
          );
          if (parsedResponse.data != null) {
            return true;
          } else {
            throw parsedResponse;
          }
        } else {
          throw response.data['message'];
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future getEstimatedRouteDistance(
      {required double originLatitude,
      required double originLongitude,
      required double destinationLatitude,
      required double destinationLongitude}) async {
    _dio.options.headers = <String, dynamic>{
      "requiresToken": true,
    };

    try {
      var queryParams = {
        'units': 'imperial',
        'origins': '$originLatitude,$originLongitude',
        'destinations': '$destinationLatitude,$destinationLongitude',
        'mode': 'driving',
        'key': Strings.gmapKey
      };

      String unencodedPath = '/maps/api/distancematrix/json';

      var uri = Uri.https(Strings.googleMapApi, unencodedPath, queryParams);
      Response response = await _dio.getUri(uri);
      if (response.statusCode == 200) {
        dynamic result = response.data["rows"][0]["elements"][0];
        return result;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future updateTrip({
    required int acquiredTruckingServiceId,
    required String status,
    required bool isOrigin,
  }) async {
    _dio.options.headers = <String, dynamic>{
      'requiresToken': true,
    };

    try {
      String unencodedPath = '/oat/api/driver-app/UpdateStatus';
      var queryParameters = {
        'acquiredTruckingServiceId': acquiredTruckingServiceId.toString(),
        'status': status,
        'isCurrentLocationOrigin': isOrigin.toString()
      };
      var uri = Uri.https(ApiPaths.proxy, unencodedPath, queryParameters);
      Response response = await _dio.postUri(uri);
      if (response.statusCode == 200) {
        ApiResponse parsedResponse = ApiResponse.fromJson(response.data);
        if (parsedResponse.data != null) {
          Trip trip = Trip.fromJson(parsedResponse.data);
          return trip;
        } else {
          return parsedResponse;
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future getCallingCodeList() async {
    _dio.options.headers = <String, dynamic>{
      'requiresToken': true,
    };
    try {
      String unencodedPath = '/global/cms/api/v1/country/callingcode';
      var uri = Uri.https(ApiPaths.proxy, unencodedPath);
      Response response = await _dio.getUri(uri);
      if (response.statusCode == 200) {
        ApiResponse parsedResponse = ApiResponse.fromJson(
          response.data,
        );
        List<CallingCode> callingCodes =
            parsedResponse.data["countries"].map<CallingCode>(
          (dynamic item) {
            return CallingCode.fromJson(item);
          },
        ).toList();
        return callingCodes;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future getDocumentCategories() async {
    _dio.options.headers = <String, dynamic>{
      'requiresToken': true,
    };
    try {
      String unencodedPath = '/oat/api/driver-app/GetDocumentCategories';
      var uri = Uri.https(ApiPaths.proxy, unencodedPath);
      Response response = await _dio.getUri(uri);
      if (response.statusCode == 200) {
        ApiResponse parsedResponse = ApiResponse.fromJson(
          response.data,
        );

        if (parsedResponse.data != null) {
          List<DocumentCategory> documentLCategoryList =
              parsedResponse.data.map<DocumentCategory>((item) {
            return DocumentCategory.fromJson(item);
          }).toList();
          return documentLCategoryList;
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future uploadRouteCompletionDocuments({
    required int acquiredTruckingServiceId,
    required String receivedBy,
    required String contactNo,
    required List<DocumentModel> documents,
    required List<Map> containerList,
    required bool isOrigin,
    required DateTime etd,
  }) async {
    _dio.options.headers = <String, dynamic>{
      "requiresToken": true,
    };
    try {
      bool isEnabled = await Geolocator.isLocationServiceEnabled();
      if (!isEnabled) {
        // throw new Exception('Location not enabled');
        throw ('Location must be enabled!');
      }

      String unencodedPath = '/oat/api/driver-app/RouteCompletion';

      var uri = Uri.https(
        ApiPaths.proxy,
        unencodedPath,
      );

      List<Map> jsonTolist = [];

      for (DocumentModel document in documents) {
        jsonTolist.add(document.toJson());
      }
      var body = json.encode({
        "acquiredTruckingServiceId": acquiredTruckingServiceId,
        "completionReceivedBy": receivedBy,
        "completionContactNo": contactNo,
        "documents": jsonTolist,
        "containerNoList": containerList,
        "isOrigin": isOrigin,
        "estimatedDateTimeArival": etd.toString()
      });

      FormData formData = FormData.fromMap({'DocumentList': body});
      await Future.wait(
        documents.map(
          (document) async {
            var mimetype = lookupMimeType(document.fileName);
            var mediaType =
                MediaType(mimetype!.split("/")[0], mimetype.split("/")[1]);
            var bytes =
                await File.fromUri(Uri.parse(document.filePath)).readAsBytes();
            formData.files.add(
              MapEntry(
                document.fileName,
                MultipartFile.fromBytes(
                  bytes,
                  filename: document.fileName,
                  contentType: mediaType,
                ),
              ),
            );
          },
        ),
      );

      Response response = await _dio.postUri(uri, data: formData);
      if (response.statusCode == 200) {
        ApiResponse parsedResponse = ApiResponse.fromJson(response.data);
        if (parsedResponse.data != null) {
          List<DocumentModel> documents =
              parsedResponse.data.map<DocumentModel>(
            (dynamic item) {
              return DocumentModel.fromJson({
                ...item,
                'isOrigin': isOrigin,
              });
            },
          ).toList();
          return documents;
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future addTrackingHistory({
    required String acquiredTruckingServiceId,
    required String tripId,
    required double latitude,
    required double longitude,
  }) async {
    _dio.options.headers = <String, dynamic>{
      "requiresToken": true,
    };
    try {
      var payload = {
        'entityId': "Mobile",
        'sourceId': "DriverApp",
        'referenceNo': '$tripId-$acquiredTruckingServiceId',
        'latitude': latitude,
        'longitude': longitude
      };

      String unencodedPath = '/Prod/api/tracking/save';
      var uri = Uri.https(ApiPaths.proxy, unencodedPath);
      Response response = await _dio.postUri(
        uri,
        data: payload,
        options: Options(
          headers: {
            'x-api-key': Strings.xKey,
          },
        ),
      );
      if (response.statusCode == 200) {
        debugPrint('in add tracking history');
        ApiResponse parsedResponse = ApiResponse.fromJson2(response.data);
        return parsedResponse;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future updateCurrentLatLng({
    required String acquiredTruckingServiceId,
    required double latitude,
    required double longitude,
    required bool isOrigin,
    required String dateUploaded,
  }) async {
    _dio.options.headers = <String, dynamic>{
      "requiresToken": true,
    };

    try {
      String unencodedPath = '/oat/api/driver-app/updateActualLatLong';

      var payload = {
        'acquiredTruckingServiceId': acquiredTruckingServiceId.toString(),
        'lng': longitude.toString(),
        'lat': latitude.toString(),
        'isOrigin': isOrigin.toString(),
        'documentUploadedDate': dateUploaded
      };
      debugPrint('===> in actual latlng');
      var uri = Uri.https(ApiPaths.proxy, unencodedPath);
      Response response = await _dio.postUri(uri, data: payload);
      if (response.statusCode == 200) {
        ApiResponse parsedResponse = ApiResponse.fromJson(response.data);
        if (parsedResponse.data != null) {
          debugPrint('in update actual lat lang');
          Trip trip = Trip.fromJson(parsedResponse.data);
          return trip;
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future getNextTrip({
    required int driverId,
    required int jobOrderId,
    required int sequenceNo,
  }) async {
    _dio.options.headers = <String, dynamic>{
      "requiresToken": true,
    };

    try {
      String unencodedPath = '/oat/api/driver-app/GetNextTrip';
      var queryParameters = {
        'driverId': driverId.toString(),
        'jobOrderId': jobOrderId.toString(),
        'sequenceNo': sequenceNo.toString()
      };

      var uri = Uri.https(ApiPaths.proxy, unencodedPath, queryParameters);
      Response response = await _dio.getUri(uri);
      if (response.statusCode == 200) {
        ApiResponse parsedResponse = ApiResponse.fromJson(response.data);
        if (parsedResponse.data != null) {
          Trip trip = Trip.fromJson(parsedResponse.data);
          return trip;
        } else {
          return parsedResponse;
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  getTripHistoryGoogle({
    required String acquiredTruckingServiceId,
    required String tripId,
    required String companyId,
  }) async {
    _dio.options.headers = <String, dynamic>{
      'requiresToken': true,
    };
    try {
      var queryParams = {
        'key': companyId,
      };
      String unencodedPath =
          '/Prod/api/tracking/referenceNo/$tripId-$acquiredTruckingServiceId/snapToRoad/lines';
      var uri = Uri.https(ApiPaths.proxy, unencodedPath, queryParams);
      Response response = await _dio.getUri(
        uri,
        options: Options(
          headers: {
            'x-api-key': Strings.xKey,
          },
        ),
      );
      if (response.statusCode == 200) {
        ApiResponse parsedeResponse = ApiResponse.fromJson2(response.data);
        if (parsedeResponse.data != null) {
          PlottingLines lines = PlottingLines.fromJson(parsedeResponse.data);
          return lines;
        }
      }
    } catch (e) {
      rethrow;
    }
  }
}
