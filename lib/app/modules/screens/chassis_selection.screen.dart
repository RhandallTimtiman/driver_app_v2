import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChassisSelectionScreen extends StatefulWidget {
  const ChassisSelectionScreen({Key? key}) : super(key: key);

  @override
  State<ChassisSelectionScreen> createState() => _ChassisSelectionScreenState();
}

class _ChassisSelectionScreenState extends State<ChassisSelectionScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: MainAppBar(
        title: Text(
          'select_chassis_label'.tr,
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/white-map.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: GetBuilder<VehicleController>(
          builder: (_) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _.chassisList.isNotEmpty
                      ? ListView.builder(
                          itemCount: _.chassisList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: GestureDetector(
                                onTap: () {
                                  _.setTemporaryChassis(_.chassisList[index]);
                                },
                                child: Hero(
                                  tag:
                                      'chassis-${_.chassisList[index].id.toString()}',
                                  child: Material(
                                    child: ChassisCard(
                                      chassis: _.chassisList[index],
                                      isSelected: _.temporaryChassis.value.id
                                              .toString() ==
                                          _.chassisList[index].id.toString(),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Text(
                            'no_chassis_label'.tr,
                          ),
                        ),
                ),
                GetBuilder<VehicleController>(
                  builder: (_) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 12.0, bottom: 40),
                      child: Hero(
                        tag: 'select-chassis',
                        child: RaisedGradientButton(
                          child: Text(
                            'select_chassis_label'.tr,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: <Color>[
                              Color.fromRGBO(0, 172, 235, 1),
                              Color.fromRGBO(0, 209, 255, 1),
                            ],
                          ),
                          onPressed: () {
                            _.updateCurrentChassis();
                            Get.back();
                          },
                        ),
                      ),
                    );
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
