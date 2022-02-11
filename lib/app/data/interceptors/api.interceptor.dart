import 'package:dio/dio.dart';
import 'package:driver_app/app/core/utils/database.helper.dart';
import 'package:driver_app/app/core/utils/utilities.dart';
import 'package:driver_app/app/data/services/services.dart';
import 'package:flutter/material.dart';

class ApiInterceptor extends Interceptor {
  final dbHelper = DatabaseHelper.instance;

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.headers["requiresToken"] == false) {
      debugPrint(
        'REQUEST[${options.method}] => PATH: ${options.path} => Without Token',
      );

      options.headers.remove("requiresToken");
      return handler.next(options);
    }

    final token = await dbHelper.queryTokenTable();

    options.headers["Accept"] = "application/json";
    options.headers["Content-Type"] = "application/json";
    options.headers["Authorization"] = "Bearer ${token.first['accessToken']}";

    debugPrint(
      'REQUEST[${options.method}] => PATH: ${options.path} => With Token',
    );

    return super.onRequest(
      options,
      handler,
    );
  }

  @override
  onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    return super.onResponse(
      response,
      handler,
    );
  }

  @override
  onError(DioError err, ErrorInterceptorHandler handler) async {
    debugPrint(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');

    if (err.response?.statusCode == 403) {
      final result = await AuthService().refreshExpiredToken();

      debugPrint(result.toString());
      if (result) {
        final token = await dbHelper.queryTokenTable();

        err.requestOptions.headers["Authorization"] =
            "Bearer ${token.first['accessToken']}";

        final opts = Options(
          method: err.requestOptions.method,
          headers: err.requestOptions.headers,
        );

        final cloneReq = await Dio().request(
          err.requestOptions.path,
          options: opts,
          data: err.requestOptions.data,
          queryParameters: err.requestOptions.queryParameters,
        );

        debugPrint("Success Refresh Token ===>");

        return handler.resolve(cloneReq);
      } else {
        debugPrint("Fail Refresh Token ===>");

        Utilities().logout();
      }
    }

    return super.onError(
      err,
      handler,
    );
  }
}
