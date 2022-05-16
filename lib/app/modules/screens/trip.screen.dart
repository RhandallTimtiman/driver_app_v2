import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TripScreen extends StatefulWidget {
  const TripScreen({Key? key}) : super(key: key);

  @override
  _TripScreenState createState() => _TripScreenState();
}

final CurrentTripController _currentTripController = Get.find();

final TripScreenMapGoogleController _googleController = Get.find();

class _TripScreenState extends State<TripScreen> {
  bool _isCollapsed = false;

  double _width = 0.0;
  _toggleCollapse() {
    setState(() {
      _isCollapsed = !_isCollapsed;
    });
  }

  void _closeAnimatedCircle() {
    setState(() {
      _width = 10;
    });
  }

  void _openAnimatedCircle() {
    setState(() {
      _width = 420.0;
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
            child: GetBuilder<TripScreenMapGoogleController>(
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
                    child: GetX<CurrentTripController>(
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
            bottom: 205,
            child: RawMaterialButton(
              onPressed: () => {
                _googleController.goToCurrentLocation(),
              },
              elevation: 3,
              fillColor: Colors.white,
              shape: const CircleBorder(),
              child: const Image(
                image: AssetImage('assets/icons/locator.png'),
                width: 22,
              ),
              padding: const EdgeInsets.all(
                20,
              ),
            ),
          ),
          Positioned(
            right: -135,
            bottom: -50,
            child: AnimatedSize(
              duration: const Duration(milliseconds: 100),
              curve: Curves.ease,
              child: Container(
                width: _width,
                height: _width,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(
                    0,
                    129,
                    174,
                    1,
                  ),
                ),
              ),
            ),
          ),
          FancyButton(
            openAnimatedCircle: _openAnimatedCircle,
            closeAnimatedCircle: _closeAnimatedCircle,
            screen: 'trip',
            bottom: 135.0,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: RouteSegment(
              trip: _currentTripController.currentTrip.value.trip,
              isCollapsed: _isCollapsed,
              toggleCollapse: _toggleCollapse,
            ),
          ),
        ],
      ),
    );
  }
}
