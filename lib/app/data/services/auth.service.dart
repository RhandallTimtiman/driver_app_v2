import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:driver_app/app/core/constants/api_paths.dart';
import 'package:driver_app/app/data/interceptors/api.interceptor.dart';
import 'package:driver_app/app/data/interfaces/interfaces.dart';
import 'package:driver_app/app/data/models/models.dart';

class AuthService extends IAuth {
  final _dio = Dio()..interceptors.add(ApiInterceptor());

  @override
  Future signIn({
    required String username,
    required String pin,
  }) async {
    _dio.options.headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };

    try {
      var uri = Uri.https(ApiPaths.proxy, '/api/auth/login');

      Response response = await _dio.postUri(
        uri,
        data: {
          'username': username,
          'pin': pin,
        },
      );

      if (response.statusCode == 200) {
        ApiResponse parsedResponse = ApiResponse.fromJson(
          response.data,
        );

        if (parsedResponse.data != null) {
          // debugPrint('Error Here');

          inspect(response);
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
