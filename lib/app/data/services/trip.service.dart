import 'package:dio/dio.dart';
import 'package:driver_app/app/core/constants/api_paths.dart';
import 'package:driver_app/app/core/constants/strings.dart';
import 'package:driver_app/app/data/interceptors/api.interceptor.dart';
import 'package:driver_app/app/data/interfaces/interfaces.dart';
import 'package:driver_app/app/data/models/models.dart';
import 'package:flutter/material.dart';

class TripService extends ITrip {
  final _dio = Dio()..interceptors.add(ApiInterceptor());

  @override
  Future getTripByStatus({
    required String driverId,
    required String status,
  }) async {
    _dio.options.headers = <String, dynamic>{
      "requiresToken": true,
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
  Future acceptTrip({
    required String driverId,
    required int acquiredTruckingServiceId,
  }) async {
    _dio.options.headers = <String, dynamic>{
      "requiresToken": true,
    };
    try {
      var queryParameters = {
        'acquiredTruckingServiceId': acquiredTruckingServiceId.toString(),
        'driverId': driverId.toString()
      };
      String unencodedPath = '/oat/api/driver-app/AcceptTrip';

      var uri = Uri.https(ApiPaths.proxy, unencodedPath, queryParameters);

      Response response = await _dio.postUri(uri);
      if (response.statusCode == 200) {
        ApiResponse parsedResponse = ApiResponse.fromJson(
          response.data,
        );
        if (parsedResponse.data != null) {
          return parsedResponse;
        } else {
          return parsedResponse;
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future getTripDetails({
    required int acquiredTruckingServiceId,
  }) async {
    _dio.options.headers = <String, dynamic>{
      "requiresToken": true,
    };

    try {
      String unencodedPath = '/oat/api/driver-app/TripDetails';
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
          Trip trip = Trip.fromJson(parsedResponse.data);
          return trip;
        } else {
          throw parsedResponse;
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future acceptAllTrip({
    required List<Map<String, dynamic>> trips,
    required int driverId,
  }) async {
    _dio.options.headers = <String, dynamic>{"requiresToken": true};

    try {
      String unencodedPath = '/oat/api/driver-app/BulkUpdateStatus';
      var queryParameters = {
        'tripStatusId': "PEN",
        'tripCollections': trips,
        'driverId': driverId.toString()
      };
      var uri = Uri.https(ApiPaths.proxy, unencodedPath);
      Response response = await _dio.postUri(uri, data: queryParameters);
      if (response.statusCode == 200) {
        ApiResponse parsedResponse = ApiResponse.fromJson(
          response.data,
        );
        if (parsedResponse.data != null) {
          return parsedResponse;
        } else {
          return parsedResponse;
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future getNewTrip({
    required int driverId,
    required int jobOrder,
  }) async {
    _dio.options.headers = <String, dynamic>{
      "requiresToken": true,
    };
    try {
      String unencodedPath = '/oat/api/driver-app/NewTripPopUp';

      var queryParameters = {
        'driverId': driverId.toString(),
        'jobOrder': jobOrder.toString()
      };

      var uri = Uri.https(ApiPaths.proxy, unencodedPath, queryParameters);
      Response response = await _dio.getUri(uri);

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
  Future rejectSelectedTrip({
    required int acquiredTruckingServiceId,
    required String remarks,
    required String reasonOfRejectionId,
  }) async {
    _dio.options.headers = <String, dynamic>{
      "requiresToken": true,
    };
    try {
      var queryParameters = {
        'acquiredTruckingServiceId': acquiredTruckingServiceId.toString(),
        'remarks': remarks.isEmpty ? remarks : '',
        'reasonOfRejectionId': reasonOfRejectionId
      };
      String unencodedPath = '/oat/api/driver-app/RejectTrip';

      var uri = Uri.https(ApiPaths.proxy, unencodedPath, queryParameters);
      Response response = await _dio.postUri(uri);

      if (response.statusCode == 200) {
        return response.data;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future getListOfReasonOfRejection() async {
    _dio.options.headers = <String, dynamic>{
      "requiresToken": true,
    };
    try {
      String unencodedPath = '/oat/api/driver-app/GetReasonsOfRejection';
      var uri = Uri.https(ApiPaths.proxy, unencodedPath);

      Response response = await _dio.getUri(uri);
      if (response.statusCode == 200) {
        ApiResponse parsedResponse = ApiResponse.fromJson(
          response.data,
        );
        if (parsedResponse.data != null) {
          List<ReasonRejection> reasonList = parsedResponse.data
              .map<ReasonRejection>((item) => ReasonRejection.fromJson(item))
              .toList();
          return reasonList;
        } else {
          throw parsedResponse;
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
      'requiresToken': true,
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
        ApiResponse parsedResponse = ApiResponse.fromJson2(response.data);
        return parsedResponse;
      }
    } catch (e) {
      rethrow;
    }
  }
}
