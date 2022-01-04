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

        Map<String, dynamic> row = {
          'accessToken': parsedResponse.accessToken,
          'refreshToken': parsedResponse.refreshToken
        };

        await dbHelper.upsertToken(row);

        if (parsedResponse.data != null) {
          return Driver.fromJson(parsedResponse.data);
        } else {
          throw parsedResponse;
        }
      }
    } catch (e) {
      rethrow;
    }
  }
}
