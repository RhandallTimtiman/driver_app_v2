import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/data/models/models.dart';
import 'package:driver_app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RouteSegment extends StatefulWidget {
  final Trip trip;
  final Function toggleCollapse;
  final bool isCollapsed;
  final bool inSimulate;
  const RouteSegment({
    Key? key,
    required this.trip,
    required this.toggleCollapse,
    required this.isCollapsed,
    this.inSimulate = false,
  }) : super(key: key);

  @override
  State<RouteSegment> createState() => _RouteSegmentState();
}

class _RouteSegmentState extends State<RouteSegment> {
  final CurrentTripController _currentTripController = Get.find();
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
                    widget.toggleCollapse();
                  }),
                  child: Container(
                    constraints: const BoxConstraints(minHeight: 110),
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
                            GetX<CurrentTripController>(
                              builder: (_) {
                                return _.currentTrip.value.trip.statusId !=
                                        'COM'
                                    ? Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'your_location_label'.tr,
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              widget.trip.origin.address,
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
                                      )
                                    : Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'start_trip_label'.tr,
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                ),
                                                const SizedBox(
                                                  width: 10.0,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    _.currentTrip.value.trip
                                                                .actualStart !=
                                                            null
                                                        ? DateFormat(
                                                                'MMMM dd, yyyy hh:mm a')
                                                            .format(
                                                              _
                                                                  .currentTrip
                                                                  .value
                                                                  .trip
                                                                  .actualStart!
                                                                  .toLocal(),
                                                            )
                                                            .toString()
                                                        : '-',
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 5.0,
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'end_trip_label'.tr,
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                ),
                                                const SizedBox(
                                                  width: 10.0,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    _.currentTrip.value.trip
                                                                .actualTimeArival !=
                                                            null
                                                        ? DateFormat(
                                                                'MMMM dd, yyyy hh:mm a')
                                                            .format(
                                                              _
                                                                  .currentTrip
                                                                  .value
                                                                  .trip
                                                                  .actualTimeArival!
                                                                  .toLocal(),
                                                            )
                                                            .toString()
                                                        : '-',
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                              },
                            )
                          ],
                        ),
                        widget.isCollapsed
                            ? GetBuilder<CurrentTripController>(builder: (_) {
                                return Column(
                                  children: [
                                    OriginDestinationWidget(
                                      isCard: true,
                                      routeName:
                                          'Route ${widget.trip.routeName}',
                                      origin: widget.trip.origin.address,
                                      destination:
                                          widget.trip.destination.address,
                                      originInstruction:
                                          widget.trip.origin.instruction,
                                      destinationInstruction:
                                          widget.trip.destination.instruction,
                                      color: Colors.white,
                                      routeColor:
                                          const Color.fromRGBO(0, 129, 174, 1),
                                      isCompleted:
                                          widget.trip.statusId == 'COM',
                                      arrival: widget
                                                  .trip.actualTimeDeparture !=
                                              null
                                          ? DateFormat('MMMM dd, yyyy hh:mm a')
                                              .format(
                                                widget.trip.actualTimeDeparture!
                                                    .toLocal(),
                                              )
                                              .toString()
                                          : '-',
                                      end: widget.trip.actualTimeArival != null
                                          ? DateFormat('MMMM dd, yyyy hh:mm a')
                                              .format(
                                                widget.trip.actualTimeArival!
                                                    .toLocal(),
                                              )
                                              .toString()
                                          : '-',
                                    ),
                                    if (!widget.inSimulate &&
                                            _.currentTrip.value.trip.statusId ==
                                                'PEN' ||
                                        _.currentTrip.value.trip.statusId ==
                                            'ONG')
                                      Container(
                                        width: size.width,
                                        constraints: const BoxConstraints(
                                          maxWidth: 500,
                                        ),
                                        child: RawMaterialButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              10.0,
                                            ),
                                          ),
                                          fillColor: const Color.fromRGBO(
                                            255,
                                            183,
                                            0,
                                            1,
                                          ),
                                          onPressed: () => {
                                            _currentTripController
                                                .getOnGoingTrip()
                                          },
                                          child: Text(
                                            _.currentTrip.value.trip.statusId ==
                                                    'PEN'
                                                ? 'start_trip_label'.tr
                                                : _.currentTrip.value.trip
                                                        .isOrigin
                                                    ? 'Arrived'
                                                    : 'End trip',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    if (!widget.inSimulate &&
                                        widget.trip.statusId == 'COM')
                                      Container(
                                        width: size.width,
                                        constraints: const BoxConstraints(
                                          maxWidth: 500,
                                        ),
                                        child: RawMaterialButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          fillColor: const Color.fromRGBO(
                                            255,
                                            183,
                                            0,
                                            1,
                                          ),
                                          onPressed: () => {
                                            Get.toNamed(
                                              '/route-simulation',
                                            )
                                          },
                                          child: Text(
                                            'simulate_route_label'.tr,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      )
                                  ],
                                );
                              })
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
