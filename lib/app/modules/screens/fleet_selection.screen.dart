import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FleetSelectionScreen extends StatefulWidget {
  const FleetSelectionScreen({Key? key}) : super(key: key);

  @override
  _FleetSelectionScreenState createState() => _FleetSelectionScreenState();
}

class _FleetSelectionScreenState extends State<FleetSelectionScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  DriverController driverController = Get.find();

  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Get.find<OngoingTripController>().checkIfHasPendingTrip();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      appBar: MainAppBar(
        title: Text(
          'fleet_selection_label'.tr,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        onMenuPress: () => openDrawer(),
        showOnlineButton: false,
      ),
      drawer: const MainDrawer(),
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/white-map.png",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: size.height - 180,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20.0,
                    ),
                    child: Obx(
                      () => Text(
                        'welcome_label'.trParams({
                          'name': driverController.getFullName(),
                        }),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  DriverCard(
                    driver: driverController.driver.value,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'vehicle_assignment_label'.tr,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  GetBuilder<VehicleController>(
                    init: VehicleController(),
                    builder: (_) {
                      if (_.vehicle.value.id != null) {
                        return Hero(
                          tag: 'vehicle-' + _.vehicle.value.id.toString(),
                          child: Material(
                            child: Container(
                              constraints: const BoxConstraints(
                                maxWidth: 500,
                              ),
                              child: VehicleCard(
                                vehicle: _.vehicle.value,
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Container(
                          constraints: const BoxConstraints(
                            maxWidth: 500,
                          ),
                          margin: const EdgeInsets.only(top: 12, bottom: 24),
                          child: Column(
                            children: [
                              Text(
                                'no_vehicle_label'.tr,
                                style: const TextStyle(
                                  color: Colors.black38,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              InkWell(
                                child: Text(
                                  'contact_admin_label'.tr,
                                  style: const TextStyle(
                                    color: Colors.black38,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'chassis_assignment_label'.tr,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  GetBuilder<VehicleController>(builder: (_) {
                    if (_.chassis.value.id != null) {
                      return GestureDetector(
                        onTap: () {
                          _.updateTemporaryChassis();
                          Get.toNamed('/select-chassis');
                        },
                        child: Hero(
                          tag: 'chassis-' + _.chassis.value.id.toString(),
                          child: Material(
                            child: Container(
                              constraints: const BoxConstraints(
                                maxWidth: 500,
                              ),
                              child: ChassisCard(
                                chassis: _.chassis.value,
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        margin: const EdgeInsets.only(top: 12, bottom: 24),
                        child: Column(
                          children: [
                            Text(
                              'no_chassis_label'.tr,
                              style: const TextStyle(
                                color: Colors.black38,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              constraints: const BoxConstraints(
                                maxWidth: 500,
                              ),
                              child: Hero(
                                tag: 'select-chassis',
                                child: RaisedGradientButton(
                                  child: Text(
                                    'select_chassis_label'.tr,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
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
                                    Get.toNamed('/select-chassis');
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  }),
                  const SizedBox(
                    height: 30,
                  ),
                  GetBuilder<VehicleController>(builder: (_) {
                    return Container(
                      width: double.infinity,
                      constraints: const BoxConstraints(
                        maxWidth: 500,
                      ),
                      // ignore: deprecated_member_use
                      child: RaisedButton(
                        padding: const EdgeInsets.symmetric(horizontal: 70),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        onPressed: () {
                          Get.find<StatusController>()
                              .toggleCurrentStatusFleetSelection(callback: () {
                            Get.offAllNamed('/dashboard');
                          });
                        },
                        child: Text(
                          'go_online_label'.tr,
                          style: const TextStyle(color: Colors.white),
                        ),
                        color: _.vehicle.value.id == null
                            ? Colors.grey
                            : const Color.fromRGBO(0, 174, 0, 1),
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 30,
                  ),
                  GetBuilder<VehicleController>(builder: (_) {
                    if (_.isLoading.value) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(
                            value: null,
                            strokeWidth: 7.0,
                            backgroundColor: Color.fromRGBO(4, 164, 223, 1),
                          ),
                        ),
                      );
                    } else {
                      return const Image(
                        width: 90,
                        image: AssetImage('assets/images/powered-by.png'),
                      );
                    }
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
