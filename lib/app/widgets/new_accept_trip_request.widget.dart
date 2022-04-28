import 'dart:async';
import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/data/models/models.dart';
import 'package:driver_app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class NewAcceptTripRequest extends StatefulWidget {
  final String title;
  final bool isFromNotification;
  final Trip trip;

  const NewAcceptTripRequest({
    Key? key,
    required this.title,
    this.isFromNotification = false,
    required this.trip,
  }) : super(key: key);

  @override
  State<NewAcceptTripRequest> createState() => _NewAcceptTripRequestState();
}

class _NewAcceptTripRequestState extends State<NewAcceptTripRequest> {
  final TripController _tripController = Get.find();
  double _progress = 1;

  int _timeCount = 15;

  late Timer _timer;

  late Timer _timer2;

  void startTimer() {
    _timer = Timer.periodic(
      const Duration(milliseconds: 100),
      (Timer time) => setState(
        () {
          if (_progress <= 0) {
            time.cancel();
          } else {
            _progress -= 0.0065;
          }
        },
      ),
    );
    _timer2 = Timer.periodic(
      const Duration(seconds: 1),
      (Timer time) => setState(
        () {
          if (_timeCount <= 0) {
            time.cancel();
            Get.back(result: false);
          } else {
            _timeCount -= 1;
          }
        },
      ),
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      if (widget.isFromNotification) {
        startTimer();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    if (widget.isFromNotification) {
      _timer.cancel();
      _timer2.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      constraints: const BoxConstraints(
        maxWidth: 500,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Row(
                  children: [
                    widget.isFromNotification
                        ? Stack(
                            children: [
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Center(
                                    child: Text(_timeCount.toString()),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(
                                  strokeWidth: 5.0,
                                  backgroundColor: Colors.grey[100],
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                    Color.fromRGBO(3, 127, 170, 1),
                                  ),
                                  value: _progress,
                                ),
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        widget.title,
                        style: const TextStyle(
                          color: Color.fromRGBO(3, 127, 170, 1),
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Image(
                      image: AssetImage('assets/icons/todaystrip2.png'),
                      width: 40,
                    ),
                  ],
                ),
              ),
              Positioned(
                top: -2,
                right: -2,
                child: Container(
                  padding: const EdgeInsets.only(top: 4, right: 4),
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.cancel,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Divider(
            color: Colors.black38,
            height: 5,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${widget.trip.jobOrderNo}/${widget.trip.tripId}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 5),
                  child: Column(
                    children: [
                      RowDivider(
                        label: 'Delivery Date',
                        value: DateFormat('MMMM dd, yyyy')
                            .format(widget.trip.deliveryDate)
                            .toString(),
                        color: Colors.blue.shade900,
                        fontSize: 12,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      RowDivider(
                        label: 'Shipper',
                        value: widget.trip.company.name!,
                        color: Colors.blue.shade900,
                        fontSize: 12,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                OriginDestinationWidget(
                  isCard: true,
                  routeName: 'Route ${widget.trip.routeName}',
                  origin: widget.trip.origin.address,
                  originInstruction: widget.trip.origin.instruction,
                  destination: widget.trip.destination.address,
                  destinationInstruction: widget.trip.origin.instruction,
                  color: Colors.black54,
                  isCompleted: false,
                )
              ],
            ),
          ),
          const Divider(
            color: Colors.black38,
            height: 5,
          ),
          Container(
            padding: const EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RawMaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  fillColor: Colors.grey,
                  onPressed: () => {
                    widget.isFromNotification ? null : Get.back(),
                  },
                  child: Text(
                    widget.isFromNotification
                        ? 'reject_label'.tr
                        : 'close_label'.tr,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RawMaterialButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        fillColor: const Color.fromRGBO(0, 167, 229, 1),
                        onPressed: () {
                          Get.back(result: true);
                          _tripController.acceptTrip(
                            widget.trip.acquiredTruckingServiceId,
                          );
                        },
                        child: Text(
                          'accept_label'.tr,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
