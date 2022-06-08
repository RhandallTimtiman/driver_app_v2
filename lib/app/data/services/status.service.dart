import 'package:dio/dio.dart';
import 'package:driver_app/app/core/constants/api_paths.dart';
import 'package:driver_app/app/data/interceptors/api.interceptor.dart';
import 'package:driver_app/app/data/interfaces/interfaces.dart';
import 'package:driver_app/app/data/models/models.dart';

class StatusService extends IStatus {
  final _dio = Dio()..interceptors.add(ApiInterceptor());

  @override
  Future updateDriverOnlineStatus({
    int? driverId,
    bool? onlineStatus,
    double? latestLat = 0.0,
    double? latestLng = 0.0,
  }) async {
    _dio.options.headers = <String, dynamic>{
      "requiresToken": true,
    };

    try {
      var payload = {
        'driverId': driverId,
        'onlineStatus': onlineStatus,
        'latestLat': latestLat,
        'latestLng': latestLng,
      };

      String unencodedPath = '/oat/api/driver-app/ChangeDriverOnlineStatus';

      var uri = Uri.https(ApiPaths.proxy, unencodedPath);

      Response response = await _dio.postUri(uri, data: payload);

      if (response.statusCode == 200) {
        ApiResponse parsedResponse = ApiResponse.fromJson(
          response.data,
        );

        if (parsedResponse.isSuccessful) {
          return parsedResponse;
        } else {
          throw parsedResponse;
        }
      }
    } catch (e) {
      rethrow;
    }
  }
}
