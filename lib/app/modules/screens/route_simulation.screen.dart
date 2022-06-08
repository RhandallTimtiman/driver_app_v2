import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RouteSimulationScreen extends StatefulWidget {
  const RouteSimulationScreen({Key? key}) : super(key: key);

  @override
  State<RouteSimulationScreen> createState() => _RouteSimulationScreenState();
}

class _RouteSimulationScreenState extends State<RouteSimulationScreen> {
  bool _isCollapsed = false;

  final RouteSimulationController _routeSimulationController = Get.find();
  _toggleCollapse() {
    setState(() {
      _isCollapsed = !_isCollapsed;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SizedBox(
            child: GetBuilder<RouteSimulationMapGoogleController>(
              builder: (_) => _.showMap(),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              padding: const EdgeInsets.only(top: 40),
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(0, 129, 174, 1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    child: GetX<RouteSimulationController>(
                      builder: (_) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              _.currentTrip.value.trip.tripId,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              _.currentTrip.value.trip.jobOrderNo,
                              style: const TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            ),
                            // Text(
                            //   '${_.currentTrip.value.trip.tripId} - ${_.currentTrip.value.trip.acquiredTruckingServiceId}',
                            //   style: const TextStyle(
                            //     fontWeight: FontWeight.w300,
                            //     color: Colors.white,
                            //   ),
                            // ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 10,
            bottom: 135,
            child: GetBuilder<RouteSimulationController>(
              builder: (_) => RawMaterialButton(
                onPressed: () {
                  if (_.index == _.combinedLines.length) {
                    setState(() {
                      _.updateIndex(0);
                    });
                    _.playRoute();
                  } else {
                    if (!_.isPaused) {
                      _.playRoute();
                    } else {
                      _.pauseRouteSimulation();
                    }
                  }
                },
                elevation: 3,
                fillColor: Colors.white,
                shape: const CircleBorder(),
                child: _.index == _.combinedLines.length
                    ? const Icon(
                        Icons.repeat,
                      )
                    : !_.isPaused
                        ? const Icon(
                            Icons.play_circle_fill_outlined,
                          )
                        : const Icon(
                            Icons.pause,
                          ),
                padding: const EdgeInsets.all(20),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: RouteSegment(
              trip: _routeSimulationController.currentTrip.value.trip,
              isCollapsed: _isCollapsed,
              toggleCollapse: _toggleCollapse,
              inSimulate: true,
            ),
          ),
        ],
      ),
    );
  }
}
