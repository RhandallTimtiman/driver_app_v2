import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/data/models/models.dart';
import 'package:driver_app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TripCompleted extends StatelessWidget {
  final Trip? nextTrip;

  const TripCompleted({Key? key, required this.nextTrip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      constraints: const BoxConstraints(
        maxWidth: 500,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              const SizedBox(
                height: 40,
              ),
              Positioned(
                top: -3,
                right: -3,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.cancel,
                    size: 35,
                  ),
                ),
              ),
            ],
          ),
          const Image(
            image: AssetImage('assets/icons/fleet-icon.png'),
            width: 80,
          ),
          const Padding(
            padding: EdgeInsets.only(
              top: 30.0,
            ),
            child: Text(
              "Your Trip to",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 4.0,
            ),
            child: GetBuilder<CurrentTripController>(
              builder: (_) {
                return Text(
                  'Route ${_.currentTrip.value.trip.routeName}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                );
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              top: 4.0,
            ),
            child: Text(
              'has been completed',
              style: TextStyle(fontSize: 20),
            ),
          ),
          nextTrip != null
              ? Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 20.0,
                      ),
                      child: Text(
                        'Proceed to next route',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 30,
                        bottom: 30,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                            ),
                            child: RaisedGradientButton(
                              width: 120,
                              child: const Text(
                                'No',
                                style: TextStyle(
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
                              onPressed: () => Get.back(),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                            ),
                            child: RaisedGradientButton(
                              width: 120,
                              child: const Text(
                                'Yes',
                                style: TextStyle(
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
                              onPressed: () async {
                                //   _showLoading(context);
                                //   try {
                                //     bool isSuccess = await tripService.acceptTrip(
                                //       nextTrip.acquiredTruckingServiceId,
                                //       nextTrip.driverId,
                                //     );

                                //     if (isSuccess) {
                                //       _setSelectedTrip(context, nextTrip);
                                //     } else {
                                //       Navigator.pop(context);
                                //     }
                                //   } catch (error) {
                                //     Navigator.pop(context);
                                //     Helpers.showAlertMessage(
                                //         context, 'Failed', error, false);
                                //   }
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              : Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 20.0),
                    child: RaisedGradientButton(
                      width: 120,
                      child: const Text(
                        'OK',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700),
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
                        Get.back();
                      },
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
