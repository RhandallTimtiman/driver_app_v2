import 'package:dio/dio.dart';
import 'package:driver_app/app/core/constants/api_paths.dart';
import 'package:driver_app/app/core/constants/strings.dart';
import 'package:driver_app/app/data/interceptors/api.interceptor.dart';
import 'package:driver_app/app/data/interfaces/interfaces.dart';
import 'package:driver_app/app/data/models/models.dart';

class DriverService extends IDriver {
  final _dio = Dio()..interceptors.add(ApiInterceptor());

  @override
  Future sendDriverLatestLocation({
    required String driverId,
    required String truckingCompanyId,
    required double latitude,
    required double longitude,
  }) async {
    _dio.options.headers = <String, dynamic>{
      "requiresToken": true,
    };
    try {
      var payload = {
        'driverId': driverId,
        'truckingCompanyId': truckingCompanyId,
        'latitude': latitude,
        'longitude': longitude
      };

      String unencodedPath = '/Prod/api/tracking/driver/location/save';

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
        if (parsedResponse.data != null) {
          return parsedResponse.data;
        }
      }
    } catch (e) {
      rethrow;
    }
  }
}
