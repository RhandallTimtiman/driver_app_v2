import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:driver_app/app/core/constants/api_paths.dart';
import 'package:driver_app/app/data/interceptors/api.interceptor.dart';
import 'package:driver_app/app/data/interfaces/interfaces.dart';
import 'package:driver_app/app/data/models/models.dart';

class VehicleService extends IVehicle {
  final _dio = Dio()..interceptors.add(ApiInterceptor());

  @override
  Future getVehicleDetails({required int driverId}) async {
    _dio.options.headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };

    try {
      var queryParameters = {
        'driverId': driverId.toString(),
      };
      String unencodedPath = '/oat/api/driver-app/VehicleInfo';
      var uri = Uri.https(ApiPaths.proxy, unencodedPath, queryParameters);

      Response response = await _dio.postUri(uri);
      if (response.statusCode == 200) {
        ApiResponse parsedResponse = ApiResponse.fromJson(
          response.data,
        );
        if (parsedResponse.data != null) {
          inspect(parsedResponse.data);
        } else {
          throw parsedResponse;
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future getChassisDetails({required int driverId}) async {
    _dio.options.headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };

    try {
      var queryParameters = {
        'driverId': driverId.toString(),
      };
      String unencodedPath = '/oat/api/driver-app/ChassisInfo';
      var uri = Uri.https(ApiPaths.proxy, unencodedPath, queryParameters);

      Response response = await _dio.postUri(uri);
      if (response.statusCode == 200) {
        ApiResponse parsedResponse = ApiResponse.fromJson(
          response.data,
        );
        if (parsedResponse.data != null) {
          inspect(parsedResponse.data);
        } else {
          throw parsedResponse;
        }
      }
    } catch (e) {
      rethrow;
    }
  }
}
