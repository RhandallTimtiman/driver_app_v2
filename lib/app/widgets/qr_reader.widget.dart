import 'dart:async';
import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrReader extends StatefulWidget {
  const QrReader({
    Key? key,
  }) : super(key: key);

  @override
  State<QrReader> createState() => _QrReaderState();
}

class _QrReaderState extends State<QrReader> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late Barcode result;
  late QRViewController controller;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController qController) {
    controller = qController;
    controller.scannedDataStream.listen((scanData) {
      Timer(const Duration(milliseconds: 300), () {
        if (scanData.code != "" && scanData.code != "0") {
          Get.back();
          Get.find<RouteCompletionController>().openQrModal(scanData.code!);
        } else {
          Get.back();
          Get.find<RouteCompletionController>().openQrModal(scanData.code!);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        size: 25,
                        color: Color.fromRGBO(
                          0,
                          129,
                          174,
                          1,
                        ),
                      ),
                      onPressed: () {
                        Get.back();
                      },
                    )
                  ],
                ),
                Container(
                  width: size.width,
                  padding: const EdgeInsets.only(
                    top: 5,
                    bottom: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Make sure the QR Code is within the frame',
                        style: TextStyle(
                          color: Color.fromRGBO(
                            0,
                            129,
                            174,
                            1,
                          ),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                      )
                    ],
                  ),
                )
              ],
            ),
            Expanded(
              flex: 5,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
                overlay: QrScannerOverlayShape(
                  borderColor: Colors.red,
                  borderRadius: 10,
                  borderLength: 30,
                  borderWidth: 10,
                  cutOutSize: 300,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
