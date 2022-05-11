import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/data/models/models.dart';
import 'package:driver_app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TripSummary extends StatefulWidget {
  const TripSummary({Key? key}) : super(key: key);

  @override
  State<TripSummary> createState() => _TripSummaryState();
}

class _TripSummaryState extends State<TripSummary> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final CurrentTripController _currentTripController = Get.find();

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _currentTripController.getTripSummary();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: MainAppBar(
        title: Column(
          children: [
            Text(
              _currentTripController.currentTrip.value.trip.jobOrderNo,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            Text(
              _currentTripController.currentTrip.value.trip.tripId,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        onBackPress: () => Get.back(),
        showOnlineButton: false,
      ),
      body: SingleChildScrollView(
        child: GetBuilder<CurrentTripController>(
          builder: (_) {
            return Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  TruckDetails(
                    vehicle: Vehicle(
                      brand: _.currentTrip.value.tripSummary.brand,
                      model: _.currentTrip.value.tripSummary.model,
                      year: _.currentTrip.value.tripSummary.year,
                      plateNumber: _.currentTrip.value.tripSummary.plateNumber,
                      type: _.currentTrip.value.tripSummary.type,
                    ),
                  ),
                  RouteDetails(
                    child: OriginDestinationWidget(
                      routeName: 'Route ',
                      origin: _.currentTrip.value.tripSummary.originAddress,
                      originInstruction: _.currentTrip.value.tripSummary
                          .originRouteInstructions,
                      destination:
                          _.currentTrip.value.tripSummary.destinationAddress,
                      destinationInstruction: _.currentTrip.value.tripSummary
                          .destinationRouteInstructions,
                      color: Colors.black54,
                      isCompleted:
                          _.currentTrip.value.tripSummary.tripStatusId == 'COM',
                      arrival:
                          _.currentTrip.value.tripSummary.actualTimeDeparture !=
                                  null
                              ? DateFormat('MMM dd, yyyy hh:mm a')
                                  .format(
                                    _.currentTrip.value.tripSummary
                                        .actualTimeDeparture!
                                        .toLocal(),
                                  )
                                  .toString()
                              : '-',
                      end: _.currentTrip.value.tripSummary.actualTimeArival !=
                              null
                          ? DateFormat('MMM dd, yyyy hh:mm a')
                              .format(
                                _.currentTrip.value.tripSummary
                                    .actualTimeArival!
                                    .toLocal(),
                              )
                              .toString()
                          : '-',
                      isFromTripSummary: true,
                      startTime:
                          _.currentTrip.value.tripSummary.actualStart != null
                              ? DateFormat('MMM dd, yyyy hh:mm a')
                                  .format(
                                    _.currentTrip.value.tripSummary.actualStart!
                                        .toLocal(),
                                  )
                                  .toString()
                              : '-',
                      deliveryDate:
                          _.currentTrip.value.tripSummary.actualTimeArival !=
                                  null
                              ? DateFormat('MMM dd, yyyy hh:mm a')
                                  .format(
                                    _.currentTrip.value.tripSummary
                                        .actualTimeArival!
                                        .toLocal(),
                                  )
                                  .toString()
                              : '-',
                      bookingParty:
                          _.currentTrip.value.tripSummary.bookingPartyName,
                    ),
                  ),
                  _.currentTrip.value.tripSummary.tripDocuments.isNotEmpty
                      ? TripAttachments(
                          tripDocuments:
                              _.currentTrip.value.tripSummary.tripDocuments,
                        )
                      : const SizedBox.shrink(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
