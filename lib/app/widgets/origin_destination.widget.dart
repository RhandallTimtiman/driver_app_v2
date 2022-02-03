import 'package:driver_app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class OriginDestinationWidget extends StatelessWidget {
  final String routeName;
  final String activeRoute;
  final String origin;
  final String originInstruction;
  final String destination;
  final String destinationInstruction;
  final Color color;
  final String arrival;
  final String end;
  final bool isCompleted;
  final bool isCard;
  final bool isFromTripSummary;
  final String startTime;
  final String deliveryDate;
  final String bookingParty;

  const OriginDestinationWidget({
    Key? key,
    required this.color,
    required this.origin,
    required this.originInstruction,
    required this.destination,
    required this.destinationInstruction,
    required this.routeName,
    this.activeRoute = '',
    required this.arrival,
    required this.end,
    this.isCompleted = false,
    this.isCard = false,
    this.isFromTripSummary = false,
    this.bookingParty = '',
    this.deliveryDate = '',
    this.startTime = '',
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isFromTripSummary
            ? Column(
                children: [
                  RowDivider(
                    label: isCompleted ? 'Start Trip' : 'Delivery Date',
                    value: isCompleted ? startTime : deliveryDate,
                    color: Colors.blue.shade900,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  RowDivider(
                    label: isCompleted ? 'End Trip' : 'Shipper',
                    value: isCompleted ? end : bookingParty,
                    color: Colors.black54,
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              )
            : const SizedBox.shrink(),
        Text(
          routeName,
          style: TextStyle(
            color: color,
            fontSize: 9,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Stack(
          children: [
            const Positioned.fill(
              child: SingleChildScrollView(
                child: DashLines(),
              ),
            ),
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          const Image(
                            image:
                                AssetImage('assets/icons/routeIndicator.png'),
                            width: 12,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Text(
                            'Origin',
                            style: TextStyle(
                              color: color,
                              fontSize: 13,
                              fontWeight: activeRoute == 'origin'
                                  ? FontWeight.w800
                                  : FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                      child: Text(
                        ':',
                        style: TextStyle(
                          color: color,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        // height: 70,
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              origin,
                              overflow: TextOverflow.ellipsis,
                              maxLines: isCard ? 2 : 5,
                              style: TextStyle(
                                color: color,
                                fontSize: 12,
                                fontWeight: activeRoute == 'origin'
                                    ? FontWeight.w800
                                    : FontWeight.w400,
                              ),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              originInstruction,
                              overflow: TextOverflow.clip,
                              maxLines: 2,
                              style: TextStyle(
                                color: color,
                                fontSize: 9,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            isCompleted
                                ? Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Arrival:',
                                        overflow: TextOverflow.clip,
                                        maxLines: 2,
                                        style: TextStyle(
                                          color: color,
                                          fontSize: 8,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 2.0,
                                      ),
                                      Expanded(
                                        child: Text(
                                          arrival,
                                          overflow: TextOverflow.clip,
                                          maxLines: 1,
                                          style: TextStyle(
                                            color: color,
                                            fontSize: 8,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox.shrink(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  color: Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            const Image(
                              image: AssetImage(
                                  'assets/icons/routeIndicator2.png'),
                              width: 14,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              'Destination',
                              style: TextStyle(
                                color: color,
                                fontSize: 13,
                                fontWeight: activeRoute == 'destination'
                                    ? FontWeight.w800
                                    : FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 20,
                        child: Text(':',
                            style: TextStyle(
                              color: color,
                            )),
                      ),
                      Flexible(
                        child: Container(
                          // height: 70,
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                destination,
                                overflow: TextOverflow.ellipsis,
                                maxLines: isCard ? 2 : 5,
                                style: TextStyle(
                                  color: color,
                                  fontSize: 12,
                                  fontWeight: activeRoute == 'destination'
                                      ? FontWeight.w800
                                      : FontWeight.w400,
                                ),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                destinationInstruction,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
                                  color: color,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              isCompleted
                                  ? Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'End Trip:',
                                          overflow: TextOverflow.clip,
                                          maxLines: 2,
                                          style: TextStyle(
                                            color: color,
                                            fontSize: 8,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 2.0,
                                        ),
                                        Expanded(
                                          child: Text(
                                            end,
                                            overflow: TextOverflow.clip,
                                            maxLines: 1,
                                            style: TextStyle(
                                              color: color,
                                              fontSize: 8,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : const SizedBox.shrink(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
