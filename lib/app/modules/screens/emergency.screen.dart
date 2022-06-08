import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmergencyScreen extends StatefulWidget {
  const EmergencyScreen({Key? key}) : super(key: key);

  @override
  _EmergencyScreenState createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  final EmergencyController _emergencyController = Get.find();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: MainAppBar(
        title: Text(
          'report_issue_label'.tr,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        onBackPress: () => Get.back(),
        showOnlineButton: true,
      ),
      drawer: const MainDrawer(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "assets/images/white-map.png",
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: SizedBox(
              height: size.height - 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                          top: 20,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GetX<EmergencyController>(
                              builder: (_) {
                                if (_.reasonList.isEmpty) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 10,
                                        ),
                                        child: Text(
                                          'reason_label'.tr + ':',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: Colors.white,
                                          border:
                                              Border.all(color: Colors.black26),
                                        ),
                                        padding: const EdgeInsets.all(4),
                                        child: const Center(
                                          child: CircularProgressIndicator(
                                            value: null,
                                            strokeWidth: 7.0,
                                            backgroundColor:
                                                Color.fromRGBO(4, 164, 223, 1),
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                } else {
                                  return ReasonWidget(
                                    reasonList: _.reasonList,
                                    reason: _emergencyController.reason.value,
                                    setReason: _emergencyController.setReason,
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      RemarksWidget(
                        controller: _emergencyController.remarksController,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.red,
                            child: MaterialButton(
                              minWidth: size.width - 100,
                              onPressed: () {
                                _emergencyController.reportIssue(
                                  isSos: false,
                                );
                              },
                              child: Text(
                                'report_issue_label'.tr,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  color: Colors.black54,
                                  width: 100,
                                  height: 1,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('OR'),
                              ),
                              Expanded(
                                child: Container(
                                  color: Colors.black54,
                                  width: 100,
                                  height: 1,
                                ),
                              ),
                            ],
                          ),
                          Material(
                            elevation: 5.0,
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.red,
                            child: MaterialButton(
                              minWidth: size.width - 100,
                              onPressed: () {
                                _emergencyController.reportIssue(
                                  isSos: true,
                                );
                              },
                              child: const Text(
                                'SOS',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: size.width,
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'note_label'.tr,
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  'click_this_emergency_label'.tr,
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Image(
                    width: 120,
                    image: AssetImage('assets/images/powered-by.png'),
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
