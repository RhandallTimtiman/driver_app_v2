import 'package:dio/dio.dart';
import 'package:driver_app/app/core/constants/api_paths.dart';
import 'package:driver_app/app/data/interceptors/api.interceptor.dart';
import 'package:driver_app/app/data/interfaces/interfaces.dart';
import 'package:driver_app/app/data/models/models.dart';

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
}
