import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;

import 'package:path_provider/path_provider.dart';

class LocationImage extends StatefulWidget {
  final File image;

  final Function returnImage;

  const LocationImage({
    Key? key,
    required this.image,
    required this.returnImage,
  }) : super(key: key);

  @override
  State<LocationImage> createState() => _LocationImageState();
}

class _LocationImageState extends State<LocationImage> {
  final today = DateTime.now();

  static GlobalKey previewContainer = GlobalKey();

  bool showSaveButton = false;

  late File modifiedImage;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Timer(const Duration(seconds: 3), () {
        takeScreenshot();
      });
    });
  }

  takeScreenshot() {
    return Future.delayed(const Duration(milliseconds: 20), () async {
      try {
        RenderRepaintBoundary boundary = previewContainer.currentContext!
            .findRenderObject()! as RenderRepaintBoundary;

        ui.Image image = await boundary.toImage(pixelRatio: 5.0);

        Directory tempDir;

        if (Platform.isAndroid) {
          tempDir = (await getExternalStorageDirectory())!;
        } else {
          tempDir = await getTemporaryDirectory();
        }

        final directory = tempDir.path;
        ByteData? byteData =
            await image.toByteData(format: ui.ImageByteFormat.png);
        Uint8List pngBytes = byteData!.buffer.asUint8List();

        File imgFile = File(
          '$directory/screenshot${today.toIso8601String()}.png',
        );
        imgFile.writeAsBytes(pngBytes);

        setState(() {
          modifiedImage = imgFile;
          showSaveButton = true;
        });
      } catch (e) {
        setState(() {
          showSaveButton = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    CurrentLocation location =
        Get.find<CurrentTripController>().currentTrip.value.location!;
    var size = MediaQuery.of(context).size;
    return RepaintBoundary(
      key: previewContainer,
      child: Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          color: Colors.black,
          child: Center(
            child: Stack(
              children: [
                Image.file(
                  widget.image,
                ),
                Positioned.fill(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      showSaveButton
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    widget.returnImage(modifiedImage);
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(
                                      6.0,
                                    ),
                                    margin: const EdgeInsets.only(
                                      top: 10,
                                      right: 10,
                                    ),
                                    child: Row(
                                      children: const [
                                        Icon(
                                          Icons.save_rounded,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "Save",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                    decoration: const BoxDecoration(
                                      color: Colors.blueAccent,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                          5,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          : const SizedBox.shrink(),
                      Container(
                        padding: const EdgeInsets.all(
                          10,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 82,
                              child: Image(
                                image: AssetImage(
                                  'assets/images/app-icon.png',
                                ),
                                color: Color.fromRGBO(255, 255, 255, 0.7),
                                colorBlendMode: BlendMode.modulate,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(
                                  10,
                                ),
                                color: Colors.black54,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      location.address,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Lat ${location.latitude}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                      ),
                                    ),
                                    Text(
                                      'Long ${location.longitude}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '${today.toLocal()}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
