import 'dart:async';
import 'package:driver_app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class NewTripRequest extends StatefulWidget {
  const NewTripRequest({Key? key}) : super(key: key);

  @override
  State<NewTripRequest> createState() => _NewTripRequestState();
}

class _NewTripRequestState extends State<NewTripRequest> {
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
            // Navigator.pop(context);
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
      startTimer();
    });
    super.initState();
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
                    Stack(
                      children: [
                        Positioned.fill(
                          child: Align(
                              alignment: Alignment.center,
                              child: Center(
                                child: Text(_timeCount.toString()),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(
                            strokeWidth: 5.0,
                            backgroundColor: Colors.grey[100],
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Color.fromRGBO(3, 127, 170, 1)),
                            value: _progress,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        'new_trip_request_label'.tr,
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
                const Text(
                  'JO-001/TN-0001',
                  style: TextStyle(
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
                            .format(DateTime.now())
                            .toString(),
                        color: Colors.blue.shade900,
                        fontSize: 12,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      RowDivider(
                        label: 'Shipper',
                        value: 'Shipper Company',
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
                  routeName: 'Route A',
                  origin: 'Sample Address',
                  destination: 'Sample Address',
                  originInstruction: 'Sample Instruction',
                  destinationInstruction: 'Sample Instruction',
                  color: Colors.black54,
                  isCompleted: false,
                  arrival: DateFormat('MMMM dd, yyyy hh:mm a')
                      .format(
                        DateTime.now(),
                      )
                      .toString(),
                  end: DateFormat('MMMM dd, yyyy hh:mm a')
                      .format(
                        DateTime.now(),
                      )
                      .toString(),
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
                  onPressed: () => {},
                  child: Text(
                    'reject_label'.tr,
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
                        onPressed: () => {},
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
