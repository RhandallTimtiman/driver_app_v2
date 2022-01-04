import 'package:dio/dio.dart';
import 'package:driver_app/app/core/utils/database.helper.dart';
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
  onError(DioError err, ErrorInterceptorHandler handler) {
    debugPrint(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    return super.onError(
      err,
      handler,
    );
  }
}
