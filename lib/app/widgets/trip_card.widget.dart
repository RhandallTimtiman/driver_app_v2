import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/data/models/models.dart';
import 'package:driver_app/app/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class TripCard extends StatelessWidget {
  final Trip trip;
  const TripCard({Key? key, required this.trip}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TripController _tripController = Get.find();

    Color statusColor;

    switch (trip.statusId) {
      case 'PEN':
        statusColor = Colors.black;
        break;
      case 'ONG':
        statusColor = const Color.fromRGBO(169, 125, 0, 1);
        break;
      case 'COM':
        statusColor = Colors.green;
        break;
      case 'MIS':
        statusColor = Colors.red;
        break;
      case 'REJ':
        statusColor = Colors.red;
        break;
      case 'REP':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.black;
    }
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      elevation: 3,
      child: GestureDetector(
        onTap: () => {_tripController.handleCurrentTrip(trip: trip)},
        child: Column(
          children: [
            Container(
              height: 10,
              decoration: BoxDecoration(
                color: trip.isReported
                    ? Colors.red
                    : const Color.fromRGBO(0, 166, 227, 1),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(50.0)),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black12,
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  '${trip.jobOrderNo}/${trip.tripId}',
                                  style: TextStyle(
                                    color: statusColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        trip.statusDescription == 'NEW'
                            ? Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: MaterialButton(
                                  onPressed: () {
                                    _tripController.openAcceptModal(trip);
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  color: const Color.fromRGBO(0, 166, 227, 1),
                                  minWidth: 0,
                                  height: 0,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 2,
                                    horizontal: 10,
                                  ),
                                  child: Text(
                                    'accept_label'.tr,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                child: Text(
                                  trip.statusDescription!,
                                  style: TextStyle(
                                    color: statusColor,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        left: BorderSide(color: Colors.black12),
                      ),
                    ),
                    width: 50,
                    height: 50,
                    child: InkWell(
                      onTap: () {
                        if (trip.statusDescription == 'NEW') {
                          final act = CupertinoActionSheet(
                            title: const Text('Select Action'),
                            actions: <Widget>[
                              CupertinoActionSheetAction(
                                child: Text(
                                  'accept_label'.tr,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                                onPressed: () {
                                  Get.back();
                                  _tripController.openAcceptModal(trip);
                                },
                              ),
                              CupertinoActionSheetAction(
                                child: Text(
                                  'reject_label'.tr,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                                onPressed: () {
                                  // setReason('Others');
                                  // rejectTrip();
                                },
                              )
                            ],
                            cancelButton: CupertinoActionSheetAction(
                              child: Text('cancel_label'.tr),
                              onPressed: () {
                                Get.back();
                              },
                            ),
                          );
                          showCupertinoModalPopup(
                            context: context,
                            builder: (BuildContext context) => act,
                          );
                        }
                        if (trip.statusId == 'COM') {
                          // _simulateTrip(context);
                        }
                      },
                      child: const Icon(
                        FontAwesomeIcons.ellipsisV,
                        size: 16,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  RowDivider(
                    label: 'delivery_date_label'.tr,
                    value: DateFormat('MMMM dd, yyyy')
                        .format(trip.deliveryDate)
                        .toString(),
                    color: Colors.blue.shade900,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  RowDivider(
                    label: 'shipper_label'.tr,
                    value: trip.company.name ?? '-',
                    color: Colors.black54,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  OriginDestinationWidget(
                    isCard: true,
                    routeName: 'Route ${trip.routeName}',
                    origin: trip.origin.address,
                    destination: trip.destination.address,
                    originInstruction: trip.origin.instruction,
                    destinationInstruction: trip.destination.instruction,
                    color: Colors.black54,
                    isCompleted: trip.statusId == 'COM',
                    arrival: trip.actualTimeDeparture != null
                        ? DateFormat('MMMM dd, yyyy hh:mm a')
                            .format(
                              trip.actualTimeDeparture!.toLocal(),
                            )
                            .toString()
                        : '-',
                    end: trip.actualTimeArival != null
                        ? DateFormat('MMMM dd, yyyy hh:mm a')
                            .format(
                              trip.actualTimeArival!.toLocal(),
                            )
                            .toString()
                        : '-',
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
