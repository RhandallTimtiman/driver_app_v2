import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signature/signature.dart';

class AddSignature extends StatefulWidget {
  const AddSignature({Key? key}) : super(key: key);

  @override
  State<AddSignature> createState() => _AddSignatureState();
}

class _AddSignatureState extends State<AddSignature> {
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
            margin: const EdgeInsets.fromLTRB(
              10,
              30,
              10,
              10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                20.0,
              ),
              color: Colors.white,
            ),
            padding: const EdgeInsets.only(
              top: 30,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: size.height - 35,
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Positioned(
                        left: 30,
                        child: GestureDetector(
                          onTap: () => Get.back(),
                          child: const Icon(
                            Icons.arrow_back,
                          ),
                        ),
                      ),
                      const Center(
                        child: Text(
                          'Your Signature',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(
                        244,
                        249,
                        251,
                        1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black54,
                      ),
                    ),
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30),
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 5,
                    ),
                    child: GetBuilder<RouteCompletionController>(builder: (_) {
                      return Stack(
                        children: [
                          Signature(
                            controller: _.signatureController,
                            height: size.height - 300,
                            width: size.width - 50,
                            backgroundColor: const Color.fromRGBO(
                              244,
                              249,
                              251,
                              1,
                            ),
                          ),
                          if (_.docs.value.signatureData == null)
                            const Positioned.fill(
                              child: Center(
                                child: Text(
                                  'Please sign here...',
                                  style: TextStyle(
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      );
                    }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(12),
                        child: RaisedGradientButton(
                          width: 80,
                          child: const Text(
                            'Clear',
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
                            setState(
                              () => Get.find<RouteCompletionController>()
                                  .signatureController
                                  .clear(),
                            );
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        child: RaisedGradientButton(
                          width: 160,
                          child: const Text(
                            'Submit Signature',
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
                            Get.find<RouteCompletionController>()
                                .saveSignature();
                          },
                        ),
                      ),
                    ],
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
