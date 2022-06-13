import 'package:dio/dio.dart';
import 'package:driver_app/app/core/constants/api_paths.dart';
import 'package:driver_app/app/data/interceptors/api.interceptor.dart';
import 'package:driver_app/app/data/interfaces/interfaces.dart';
import 'package:driver_app/app/data/models/models.dart';

class RouteSimulationService implements IRouteSimulation {
  final _dio = Dio()..interceptors.add(ApiInterceptor());

  @override
  Future getTripHistoryGoogleCombinedLines({
    required String acquiredTruckingServiceId,
    required String tripId,
    required String companyId,
  }) async {
    _dio.options.headers = <String, dynamic>{
      "requiresToken": true,
    };
    try {
      var queryParams = {
        'key': companyId,
      };
      String xkey = 'pkLta08Qv63teG4LV7ATj3ar7D4gvn7p3QdNix7k';
      String unencodedPath =
          '/Prod/api/tracking/referenceNo/$tripId-$acquiredTruckingServiceId/snapToRoad/lines/combined';

      var uri = Uri.https(ApiPaths.proxy, unencodedPath, queryParams);
      Response response = await _dio.getUri(
        uri,
        options: Options(
          headers: {
            'x-api-key': xkey,
          },
        ),
      );
      if (response.statusCode == 200) {
        ApiResponse parsedResponse = ApiResponse.fromJson2(
          response.data,
        );
        if (parsedResponse.data != null) {
          List<dynamic> coordinates = parsedResponse.data;
          return coordinates;
        } else {
          throw parsedResponse;
        }
      }
    } catch (e) {
      rethrow;
    }
  }
}
