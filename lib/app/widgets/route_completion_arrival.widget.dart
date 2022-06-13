import 'dart:async';
import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class RouteCompletionArrival extends StatefulWidget {
  const RouteCompletionArrival({Key? key}) : super(key: key);

  @override
  State<RouteCompletionArrival> createState() => _RouteCompletionArrivalState();
}

class _RouteCompletionArrivalState extends State<RouteCompletionArrival> {
  final RouteCompletionController _routeCompletionController = Get.put(
    RouteCompletionController(),
  );

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _routeCompletionController.setup();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return DraggableScrollableSheet(
        expand: true,
        initialChildSize: 1,
        minChildSize: 0.2,
        maxChildSize: 1.0,
        builder: (context, scrollController) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(
                FocusNode(),
              );
            },
            child: SingleChildScrollView(
              controller: scrollController,
              child: Container(
                margin: const EdgeInsets.fromLTRB(10, 30, 10, 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.white,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: size.height - 35,
                  ),
                  child: Column(
                    children: [
                      GetBuilder<CurrentTripController>(
                        builder: (_) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 25.0),
                                      child: Text(
                                        _.currentTrip.value.trip.jobOrderNo,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      _.currentTrip.value.trip.tripId,
                                      style: const TextStyle(
                                        color: Color.fromRGBO(0, 129, 174, 1),
                                        fontSize: 22,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(
                                      width: size.width,
                                      child: Stack(
                                        children: [
                                          Positioned(
                                            left: 10,
                                            child: GestureDetector(
                                              onTap: () => Get.back(),
                                              child: const Icon(
                                                Icons.arrow_back,
                                              ),
                                            ),
                                          ),
                                          Center(
                                            child: Text(
                                              'route_completion_label'.tr,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: Colors.black87,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(12),
                                      child: Text(
                                        'Kindly fill up the form to complete route',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(
                                  color: Colors.black87,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: OriginDestinationWidget(
                                    routeName:
                                        'Route ${_.currentTrip.value.trip.routeName}',
                                    origin:
                                        _.currentTrip.value.trip.origin.address,
                                    originInstruction: _.currentTrip.value.trip
                                        .origin.instruction,
                                    destination: _.currentTrip.value.trip
                                        .destination.address,
                                    destinationInstruction: _.currentTrip.value
                                        .trip.destination.instruction,
                                    color: Colors.black54,
                                    activeRoute:
                                        _.currentTrip.value.trip.isOrigin
                                            ? 'origin'
                                            : 'destination',
                                  ),
                                ),
                                const Divider(
                                  color: Colors.black87,
                                  height: 1,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  width: size.width,
                                  child: TextField(
                                    controller: _routeCompletionController
                                        .receivedByController,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.grey[400],
                                      ),
                                      hintText: 'Received by',
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                          color: Colors.black38,
                                          width: 1,
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                          color: Color.fromRGBO(0, 129, 174, 1),
                                          width: 3,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    GetBuilder<RouteCompletionController>(
                                        builder: (_) {
                                      if (_.loading.value) {
                                        return Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            color: Colors.white,
                                            border: Border.all(
                                                color: Colors.black26),
                                          ),
                                          padding: const EdgeInsets.all(4),
                                          child: const Center(
                                            child: CircularProgressIndicator(
                                              value: null,
                                              strokeWidth: 7.0,
                                              backgroundColor: Color.fromRGBO(
                                                244,
                                                162,
                                                64,
                                                1,
                                              ),
                                            ),
                                          ),
                                        );
                                      } else {
                                        return SizedBox(
                                          width: 100,
                                          child: CallingCodeSelect(
                                            callingCode: _.callingCode,
                                            setCallingCode: _.setCallingCode,
                                            callingCodeList: _.callingCodeList,
                                          ),
                                        );
                                      }
                                    }),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: TextField(
                                        controller: _routeCompletionController
                                            .contactNumberController,
                                        inputFormatters: [
                                          _routeCompletionController
                                              .maskFormatter,
                                          LengthLimitingTextInputFormatter(24),
                                        ],
                                        keyboardType: TextInputType.number,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          hintStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: Colors.grey[400],
                                          ),
                                          hintText: 'Contact Number',
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: const BorderSide(
                                              color: Colors.black38,
                                              width: 1,
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: const BorderSide(
                                              color: Color.fromRGBO(
                                                  0, 129, 174, 1),
                                              width: 3,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                for (var i = 0;
                                    i <
                                        _.currentTrip.value.trip.containerList
                                            .length;
                                    i++)
                                  if (_.currentTrip.value.trip.isOrigin)
                                    Column(
                                      children: [
                                        Container(
                                          width: size.width,
                                          margin:
                                              const EdgeInsets.only(bottom: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    if (_
                                                                .currentTrip
                                                                .value
                                                                .trip
                                                                .containerList[
                                                                    i]
                                                                .containerNumber !=
                                                            null &&
                                                        _
                                                                .currentTrip
                                                                .value
                                                                .trip
                                                                .containerList[
                                                                    i]
                                                                .containerNumber! !=
                                                            '') {
                                                      var availableContainer =
                                                          _routeCompletionController
                                                              .containerInformation;
                                                      final act =
                                                          CupertinoActionSheet(
                                                        title: const Text(
                                                          'Select Container Number',
                                                        ),
                                                        actions: [
                                                          for (var indexC = 0;
                                                              indexC <
                                                                  availableContainer
                                                                      .length;
                                                              indexC++)
                                                            availableContainer[
                                                                                indexC]
                                                                            [
                                                                            "hasTaken"] !=
                                                                        true &&
                                                                    availableContainer[indexC]
                                                                            [
                                                                            "containerNumber"] !=
                                                                        null &&
                                                                    availableContainer[indexC]
                                                                            [
                                                                            "containerNumber"] !=
                                                                        ''
                                                                ? CupertinoActionSheetAction(
                                                                    child: Text(
                                                                      availableContainer[
                                                                              indexC]
                                                                          [
                                                                          "containerNumber"],
                                                                      style:
                                                                          const TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            14,
                                                                      ),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      _routeCompletionController
                                                                          .updateContainerControllers(
                                                                        i,
                                                                        availableContainer,
                                                                        indexC,
                                                                      );
                                                                      Get.back();
                                                                    },
                                                                  )
                                                                : const SizedBox
                                                                    .shrink(),
                                                        ],
                                                        cancelButton:
                                                            CupertinoActionSheetAction(
                                                          child: const Text(
                                                              'Cancel'),
                                                          onPressed: () {
                                                            Get.back();
                                                          },
                                                        ),
                                                      );
                                                      showCupertinoModalPopup(
                                                        context: context,
                                                        builder: (BuildContext
                                                                context) =>
                                                            act,
                                                      );
                                                    }
                                                  },
                                                  child: TextField(
                                                    maxLength: 11,
                                                    onChanged: (text) {
                                                      _routeCompletionController
                                                          .updateContainerHasScanned(
                                                              i);
                                                    },
                                                    controller:
                                                        _routeCompletionController
                                                            .containerControllers[i],
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                    enabled: _
                                                                .currentTrip
                                                                .value
                                                                .trip
                                                                .containerList[
                                                                    i]
                                                                .containerNumber ==
                                                            null ||
                                                        _
                                                                .currentTrip
                                                                .value
                                                                .trip
                                                                .containerList[
                                                                    i]
                                                                .containerNumber ==
                                                            '',
                                                    decoration: InputDecoration(
                                                      errorText:
                                                          _routeCompletionController
                                                              .errorText(i),
                                                      suffixIcon: const Icon(
                                                        Icons
                                                            .arrow_drop_down_sharp,
                                                      ),
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                      hintStyle: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        color: Colors.grey[400],
                                                      ),
                                                      hintText:
                                                          'Container Number',
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        borderSide:
                                                            const BorderSide(
                                                          color: Colors.black38,
                                                          width: 1,
                                                        ),
                                                      ),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        borderSide:
                                                            const BorderSide(
                                                          color: Color.fromRGBO(
                                                            0,
                                                            129,
                                                            174,
                                                            1,
                                                          ),
                                                          width: 3,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                flex: 1,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: size.width,
                                          margin:
                                              const EdgeInsets.only(bottom: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: TextField(
                                                  controller:
                                                      _routeCompletionController
                                                          .trackingDeviceControllers[i],
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                  decoration: InputDecoration(
                                                    hintStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 14,
                                                      color: Colors.grey[400],
                                                    ),
                                                    hintText:
                                                        'Tracking Device ID',
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        12,
                                                      ),
                                                      borderSide:
                                                          const BorderSide(
                                                        color: Colors.black38,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      borderSide:
                                                          const BorderSide(
                                                        color: Color.fromRGBO(
                                                          0,
                                                          129,
                                                          174,
                                                          1,
                                                        ),
                                                        width: 3,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                flex: 1,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  IconButton(
                                                    icon: const Icon(
                                                      Icons.qr_code,
                                                      size: 30,
                                                      color: Color.fromRGBO(
                                                        0,
                                                        129,
                                                        174,
                                                        1,
                                                      ),
                                                    ),
                                                    onPressed: () {
                                                      Get.toNamed('qr-reader');
                                                    },
                                                  ),
                                                  Text(
                                                    'scan_label'.tr,
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color.fromRGBO(
                                                        0,
                                                        129,
                                                        174,
                                                        1,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        i !=
                                                _.currentTrip.value.trip
                                                        .containerList.length -
                                                    1
                                            ? Container(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8),
                                                child: const Divider(
                                                  color: Colors.black87,
                                                  height: 1,
                                                ),
                                              )
                                            : const SizedBox.shrink(),
                                      ],
                                    ),
                              ],
                            ),
                          );
                        },
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        child: RaisedGradientButton(
                          width: 250,
                          child: const Text(
                            'Add Document',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: <Color>[
                              Color.fromRGBO(
                                0,
                                172,
                                235,
                                1,
                              ),
                              Color.fromRGBO(
                                0,
                                209,
                                255,
                                1,
                              ),
                            ],
                          ),
                          onPressed: () {
                            _routeCompletionController.addDocument(null);
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GetBuilder<RouteCompletionController>(
                        builder: (_) {
                          return Column(
                            children: [
                              _.docGroup.value.documentList.isNotEmpty
                                  ? Column(
                                      children: [
                                        DocumentGroup(
                                          addDocument: _.addDocument,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(20),
                                          child: RaisedGradientButton(
                                            width: 250,
                                            child: Text(
                                              'submit_label'.tr,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            gradient: const LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: <Color>[
                                                Color.fromRGBO(
                                                  0,
                                                  172,
                                                  235,
                                                  1,
                                                ),
                                                Color.fromRGBO(
                                                  0,
                                                  209,
                                                  255,
                                                  1,
                                                ),
                                              ],
                                            ),
                                            onPressed: () {
                                              Get.find<
                                                      RouteCompletionController>()
                                                  .validateSubmit();
                                            },
                                          ),
                                        ),
                                      ],
                                    )
                                  : const SizedBox.shrink(),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
