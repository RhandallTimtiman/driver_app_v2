import 'package:dio/dio.dart';
import 'package:driver_app/app/core/constants/api_paths.dart';
import 'package:driver_app/app/data/interceptors/api.interceptor.dart';
import 'package:driver_app/app/data/interfaces/interfaces.dart';
import 'package:driver_app/app/data/models/models.dart';

class SettingsService extends ISettings {
  final _dio = Dio()..interceptors.add(ApiInterceptor());

  @override
  Future changePin(int driverId, String oldPin, String newPin) async {
    _dio.options.headers = <String, dynamic>{
      "requiresToken": true,
    };

    try {
      String unencodedPath = '/oat/api/driver-app/UpdatePin';
      var queryParameters = {
        'driverId': driverId.toString(),
        'OldPin': oldPin,
        'NewPin': newPin,
      };
      var uri = Uri.https(ApiPaths.proxy, unencodedPath, queryParameters);
      Response response = await _dio.postUri(uri);
      if (response.statusCode == 200) {
        ApiResponse parsedResponse = ApiResponse.fromJson(
          response.data,
        );
        if (parsedResponse.data != null) {
          return parsedResponse.data;
        } else {
          throw parsedResponse;
        }
      }
    } catch (e) {
      rethrow;
    }
  }
}
