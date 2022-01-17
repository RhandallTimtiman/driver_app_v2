import 'package:dio/dio.dart';
import 'package:driver_app/app/core/constants/api_paths.dart';
import 'package:driver_app/app/data/interceptors/api.interceptor.dart';
import 'package:driver_app/app/data/interfaces/interfaces.dart';
import 'package:driver_app/app/data/models/models.dart';

class EmergencyService extends IEmergency {
  final _dio = Dio()..interceptors.add(ApiInterceptor());

  @override
  Future getReportIssueType() async {
    _dio.options.headers = <String, dynamic>{
      "requiresToken": true,
    };
    try {
      String unencodedPath = '/oat/api/driver-app/GetReportType';

      var uri = Uri.https(ApiPaths.proxy, unencodedPath);

      Response response = await _dio.getUri(uri);

      if (response.statusCode == 200) {
        ApiResponse parsedResponse = ApiResponse.fromJson(
          response.data,
        );

        if (parsedResponse.data != null) {
          List<ReportIssue> obj = parsedResponse.data
              .map<ReportIssue>((item) => ReportIssue.fromJson(item))
              .toList();

          return obj;
        } else {
          throw parsedResponse;
        }
      }
    } catch (e) {
      rethrow;
    }
  }
}
