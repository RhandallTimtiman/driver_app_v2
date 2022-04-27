import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/data/models/models.dart';
import 'package:driver_app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RouteSegment extends StatelessWidget {
  final Trip trip;
  final Function toggleCollapse;
  final bool isCollapsed;
  const RouteSegment(
      {Key? key,
      required this.trip,
      required this.toggleCollapse,
      required this.isCollapsed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Wrap(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            child: Wrap(
              children: [
                Container(
                  height: 7,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(50.0),
                    ),
                    color: Color.fromRGBO(255, 183, 0, 1),
                  ),
                ),
                GestureDetector(
                  onTap: (() {
                    toggleCollapse();
                  }),
                  child: Container(
                    constraints: const BoxConstraints(minHeight: 120),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(0, 129, 174, 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset:
                              const Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.keyboard_arrow_up,
                              size: 30,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Your Location',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    trip.origin.address,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        isCollapsed
                            ? GetX<CurrentTripController>(
                                builder: (_) {
                                  return Column(
                                    children: [
                                      OriginDestinationWidget(
                                        isCard: true,
                                        routeName: 'Route ${trip.routeName}',
                                        origin: trip.origin.address,
                                        destination: trip.destination.address,
                                        originInstruction:
                                            trip.origin.instruction,
                                        destinationInstruction:
                                            trip.destination.instruction,
                                        color: Colors.white,
                                        routeColor: const Color.fromRGBO(
                                            0, 129, 174, 1),
                                        isCompleted: trip.statusId == 'COM',
                                        arrival:
                                            trip.actualTimeDeparture != null
                                                ? DateFormat(
                                                        'MMMM dd, yyyy hh:mm a')
                                                    .format(
                                                      trip.actualTimeDeparture!
                                                          .toLocal(),
                                                    )
                                                    .toString()
                                                : '-',
                                        end: trip.actualTimeArival != null
                                            ? DateFormat(
                                                    'MMMM dd, yyyy hh:mm a')
                                                .format(
                                                  trip.actualTimeArival!
                                                      .toLocal(),
                                                )
                                                .toString()
                                            : '-',
                                      ),
                                      _.currentTrip.value.trip.statusId == 'PEN'
                                          ? Container(
                                              width: size.width,
                                              constraints: const BoxConstraints(
                                                maxWidth: 500,
                                              ),
                                              child: RawMaterialButton(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                fillColor: const Color.fromRGBO(
                                                  255,
                                                  183,
                                                  0,
                                                  1,
                                                ),
                                                onPressed: () => {},
                                                child: Text(
                                                  'start_trip_label'.tr,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : const SizedBox.shrink()
                                    ],
                                  );
                                },
                              )
                            : const SizedBox(
                                height: 5,
                              )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
