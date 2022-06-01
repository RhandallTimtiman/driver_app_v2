import 'package:dio/dio.dart';
import 'package:driver_app/app/core/constants/api_paths.dart';
import 'package:driver_app/app/core/constants/strings.dart';
import 'package:driver_app/app/data/interceptors/api.interceptor.dart';
import 'package:driver_app/app/data/interfaces/interfaces.dart';
import 'package:driver_app/app/data/models/models.dart';
import 'package:flutter/material.dart';

class CurrentTripService implements ICurrentTrip {
  final _dio = Dio()..interceptors.add(ApiInterceptor());

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
        Trip trip = Trip.fromJson(response.data);
        return trip;
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
}
