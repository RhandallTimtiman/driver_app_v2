import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationListScreen extends StatefulWidget {
  const NotificationListScreen({Key? key}) : super(key: key);

  @override
  _NotificationListScreenState createState() => _NotificationListScreenState();
}

class _NotificationListScreenState extends State<NotificationListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        title: Text(
          'notification_label'.tr,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        onBackPress: () => Get.back(),
        showOnlineButton: false,
      ),
      drawer: const MainDrawer(),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey[50],
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: GetBuilder<NotificationListController>(
              builder: (_) => Column(
                children: [
                  _.loading.value
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: const Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(
                                value: null,
                                strokeWidth: 7.0,
                                backgroundColor: Color.fromRGBO(4, 164, 223, 1),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                  _.notifications.isNotEmpty
                      ? ListView.builder(
                          itemCount: _.notifications.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return NotificationItem(
                              isFinal: index == _.notifications.length - 1,
                              notification: _.notifications[index],
                              index: index,
                              updateNotification: _.updateNotification,
                            );
                          },
                        )
                      : Container(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: const Center(
                            child: Text(
                              'No Available Notifications',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
