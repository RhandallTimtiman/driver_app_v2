import 'dart:developer';

import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/data/models/models.dart';
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

  VehicleController vehicleController = Get.find();

  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  void showDriver() {
    inspect(driverController.driver.value);
  }

  @override
  initState() {
    _initData();
    super.initState();
  }

  Future<void> _initData() async {
    // Vehicle vehicle = await vehicleController
    //     .getVehicleDetails(driverController.driver.value.driverId);
    // inspect(vehicle);

    // Vehicle chassis = await vehicleController
    //     .getChassisDetails(driverController.driver.value.driverId);
    // inspect(chassis);
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
        showOnlineButton: true,
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
                      () => GestureDetector(
                        onTap: showDriver,
                        child: Text(
                          'Welcome ${driverController.getFullName()}!',
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  DriverCard(driver: driverController.driver.value),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Vehicle Assignment',
                    style: TextStyle(fontWeight: FontWeight.w700),
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
