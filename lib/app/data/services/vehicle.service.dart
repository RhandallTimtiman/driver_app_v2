import 'package:dio/dio.dart';
import 'package:driver_app/app/core/constants/api_paths.dart';
import 'package:driver_app/app/data/interceptors/api.interceptor.dart';
import 'package:driver_app/app/data/interfaces/interfaces.dart';
import 'package:driver_app/app/data/models/models.dart';

class VehicleService extends IVehicle {
  final _dio = Dio()..interceptors.add(ApiInterceptor());

  @override
  Future getVehicleDetails({required String driverId}) async {
    _dio.options.headers = <String, dynamic>{
      "requiresToken": true,
    };

    try {
      var queryParameters = {
        'driverId': driverId,
      };

      String unencodedPath = '/oat/api/driver-app/VehicleInfo';

      var uri = Uri.https(ApiPaths.proxy, unencodedPath, queryParameters);

      Response response = await _dio.getUri(uri);

      if (response.statusCode == 200) {
        ApiResponse parsedResponse = ApiResponse.fromJson(
          response.data,
        );

        if (parsedResponse.data != null) {
          return Vehicle.fromJson(parsedResponse.data);
        } else {
          return Vehicle();
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future getChassisDetails({required String driverId}) async {
    _dio.options.headers = <String, dynamic>{
      "requiresToken": true,
    };

    try {
      var queryParameters = {
        'driverId': driverId,
      };
      String unencodedPath = '/oat/api/driver-app/ChassisInfo';

      var uri = Uri.https(ApiPaths.proxy, unencodedPath, queryParameters);

      Response response = await _dio.getUri(uri);

      if (response.statusCode == 200) {
        ApiResponse parsedResponse = ApiResponse.fromJson(
          response.data,
        );

        if (parsedResponse.data != null) {
          return Chassis.fromJson(parsedResponse.data);
        } else {
          return Chassis();
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future getChassisByCompany({
    required String truckingCompanyId,
  }) async {
    _dio.options.headers = <String, dynamic>{
      "requiresToken": true,
    };

    try {
      var queryParameters = {
        'truckingCompanyId': truckingCompanyId,
      };

      String unencodedPath = '/oat/api/driver-app/GetChassis';

      var uri = Uri.https(ApiPaths.proxy, unencodedPath, queryParameters);

      Response response = await _dio.getUri(uri);

      if (response.statusCode == 200) {
        ApiResponse parsedResponse = ApiResponse.fromJson(
          response.data,
        );

        if (parsedResponse.data != null) {
          List<Chassis> chassis = parsedResponse.data.map<Chassis>(
            (dynamic item) {
              return Chassis.fromJson(item);
            },
          ).toList();
          return chassis;
        } else {
          throw parsedResponse;
        }
      }
    } catch (e) {
      rethrow;
    }
  }
}
