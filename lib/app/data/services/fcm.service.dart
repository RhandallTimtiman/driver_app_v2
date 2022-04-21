import 'package:dio/dio.dart';
import 'package:driver_app/app/core/constants/api_paths.dart';
import 'package:driver_app/app/data/interceptors/api.interceptor.dart';
import 'package:driver_app/app/data/interfaces/interfaces.dart';

class FcmService extends IFcm {
  final _dio = Dio()..interceptors.add(ApiInterceptor());

  @override
  Future<bool> registerDevice({required guid, required token}) async {
    String unencodedPath = '/global/cms/api/v1/pushNotif/device/register';

    var uri = Uri.https(ApiPaths.proxy, unencodedPath);

    var payload = {
      "sourceId": guid,
      "deviceToken": token,
    };

    Response response = await _dio.postUri(
      uri,
      data: payload,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      if (response.statusCode == 403) {
        throw 'Session Expired';
      } else {
        throw Exception('Failed to Register token');
      }
    }
  }
}
