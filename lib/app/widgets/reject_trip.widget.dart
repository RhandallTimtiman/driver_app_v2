import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/data/models/models.dart';
import 'package:driver_app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RejectTrip extends StatefulWidget {
  final Trip trip;
  const RejectTrip({
    Key? key,
    required this.trip,
  }) : super(key: key);

  @override
  State<RejectTrip> createState() => _RejectTripState();
}

class _RejectTripState extends State<RejectTrip> {
  @override
  void initState() {
    Get.lazyPut(
      () => RejectTripController(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return DraggableScrollableSheet(
      expand: true,
      initialChildSize: 1.0,
      minChildSize: 0.2,
      maxChildSize: 1.0,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Container(
            margin: const EdgeInsets.fromLTRB(10, 30, 10, 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: size.height - 35,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Wrap(
                    children: [
                      Stack(
                        children: [
                          Positioned(
                            top: 20,
                            left: 20,
                            child: InkWell(
                              onTap: () => Get.back(),
                              child: const Icon(
                                Icons.arrow_back,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(
                              top: 20.0,
                              bottom: 8,
                            ),
                            child: Center(
                              child: Text(
                                'Reject Trip Request',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(
                          bottom: 4,
                        ),
                        child: Text(
                          widget.trip.jobOrderNo,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 12,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          widget.trip.tripId,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color.fromRGBO(3, 127, 169, 1),
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const Divider(
                        indent: 20,
                        endIndent: 20,
                        color: Colors.black54,
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 20,
                        ),
                        child: GetBuilder<RejectTripController>(
                          builder: (_) {
                            return Column(
                              children: [
                                ReasonWidget(
                                  reasonList: _.reasonList,
                                  reason: _.reason.value,
                                  setReason: _.setReason,
                                ),
                                _.reason.value.description == 'OTHERS'
                                    ? RemarksWidget(
                                        controller: _.remarksController,
                                      )
                                    : const SizedBox.shrink(),
                              ],
                            );
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 20,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Note: ',
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Text(
                                'You are about to reject trip request. Once you click reject, you will not be able to receive any trips',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                          ),
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            onPressed: () => Get.back(),
                            child: Text(
                              'cancel_label'.tr,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            color: Colors.grey,
                          ),
                        ),
                        GetBuilder<RejectTripController>(builder: (_) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              onPressed: () => _.handleRejectTrip(widget.trip),
                              child: const Text(
                                'Reject',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              color: Colors.grey[700],
                            ),
                          );
                        })
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
