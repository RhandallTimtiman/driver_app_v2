import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:driver_app/app/core/constants/api_paths.dart';
import 'package:driver_app/app/core/utils/database.helper.dart';
import 'package:driver_app/app/data/interceptors/api.interceptor.dart';
import 'package:driver_app/app/data/interfaces/interfaces.dart';
import 'package:driver_app/app/data/models/models.dart';

class AuthService extends IAuth {
  final _dio = Dio()..interceptors.add(ApiInterceptor());

  final dbHelper = DatabaseHelper.instance;

  @override
  Future signIn({
    required String username,
    required String pin,
  }) async {
    _dio.options.headers = <String, dynamic>{
      "requiresToken": false,
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
          Map<String, dynamic> row = {
            'accessToken': parsedResponse.accessToken,
            'refreshToken': parsedResponse.refreshToken
          };

          await dbHelper.upsertToken(row);

          return Driver.fromJson(parsedResponse.data);
        } else {
          throw parsedResponse;
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> refreshExpiredToken() async {
    final tempDio = Dio();

    tempDio.options.headers = <String, dynamic>{
      'Accept': 'application/json',
      'Content-Type': 'application/json;charset=UTF-8',
      'Charset': 'utf-8',
    };

    final result = await dbHelper.queryTokenTable();

    try {
      var uri = Uri.https(ApiPaths.proxy, '/api/auth/refresh-token');

      Response response = await tempDio.postUri(
        uri,
        data: {
          'accessToken': result.first['accessToken'],
          'refreshToken': result.first['refreshToken'],
        },
      );

      if (response.statusCode == 200) {
        ApiResponse parsedResponse = ApiResponse.fromJson(
          response.data,
        );

        Map<String, dynamic> row = {
          'accessToken': parsedResponse.accessToken,
          'refreshToken': parsedResponse.refreshToken
        };

        await dbHelper.upsertToken(row);

        return true;
      } else {
        throw false;
      }
    } catch (e) {
      return false;
    }
  }
}
