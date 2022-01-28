import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:driver_app/app/core/constants/api_paths.dart';
import 'package:driver_app/app/data/interceptors/api.interceptor.dart';
import 'package:driver_app/app/data/interfaces/interfaces.dart';
import 'package:driver_app/app/data/models/models.dart';

class TripService extends ITrip {
  final _dio = Dio()..interceptors.add(ApiInterceptor());

  @override
  Future getTripByStatus(
      {required String driverId, required String status}) async {
    _dio.options.headers = <String, dynamic>{
      "requiresToken": true,
    };
    try {
      var queryParameters = {
        'driverId': driverId.toString(),
        'status': status == 'All' ? [] : status.split(',')
      };
      String unencodedPath = '/oat/api/driver-app/GetTripsPerDriver';

      var uri = Uri.https(ApiPaths.proxy, unencodedPath);

      Response response = await _dio.postUri(uri, data: queryParameters);
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
}
