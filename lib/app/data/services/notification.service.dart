import 'package:dio/dio.dart';
import 'package:driver_app/app/core/constants/api_paths.dart';
import 'package:driver_app/app/data/interceptors/api.interceptor.dart';
import 'package:driver_app/app/data/interfaces/interfaces.dart';
import 'package:driver_app/app/data/models/models.dart';

class NotificationService extends INotification {
  final _dio = Dio()..interceptors.add(ApiInterceptor());

  @override
  Future getNotifications({
    required driverId,
  }) async {
    _dio.options.headers = <String, dynamic>{
      "requiresToken": true,
    };

    try {
      String unencodedPath = '/oat/api/driver-app/GetNotificationList';

      var queryParameters = {
        'driverId': driverId.toString(),
      };

      var uri = Uri.https(ApiPaths.proxy, unencodedPath, queryParameters);

      Response response = await _dio.getUri(uri);

      if (response.statusCode == 200) {
        ApiResponse parsedResponse = ApiResponse.fromJson(
          response.data,
        );
        if (parsedResponse.data != null) {
          List<NotificationModel> notification = parsedResponse.data
              .map<NotificationModel>(
                  (item) => NotificationModel.fromJson(item))
              .toList();
          return notification;
        } else {
          throw parsedResponse;
        }
      }
      return '';
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future updateNotification({
    required int driverNotificationId,
    required bool isRead,
  }) async {
    _dio.options.headers = <String, dynamic>{
      "requiresToken": true,
    };
    try {
      var payload = {
        'driverNotificationsId': driverNotificationId.toString(),
        'isRead': isRead,
      };
      String unencodedPath = '/oat/api/driver-app/UpdateIsReadStatus';
      var uri = Uri.https(ApiPaths.proxy, unencodedPath);

      Response response = await _dio.postUri(uri, data: payload);

      if (response.statusCode == 200) {
        ApiResponse parsedResponse = ApiResponse.fromJson(
          response.data,
        );
        if (parsedResponse.data != null) {
          NotificationModel notification = NotificationModel.fromJson(
            parsedResponse.data,
          );
          return notification;
        } else {
          throw parsedResponse;
        }
      }
    } catch (e) {
      rethrow;
    }
  }
}
