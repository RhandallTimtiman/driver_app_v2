import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:get/get.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => NotificationListController(),
    );
  }
}
