import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScannerView extends StatelessWidget {
  final String value;
  final Function setContainerNumber;
  const ScannerView({
    Key? key,
    required this.value,
    required this.setContainerNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    bool type = value != "" ? true : false;

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
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: size.height - 110,
                  width: size.width,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                              right: 10,
                            ),
                            child: IconButton(
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
                            ),
                          )
                        ],
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Icon(
                                  type
                                      ? Icons.check_circle_rounded
                                      : Icons.info_rounded,
                                  size: 100,
                                  color: type
                                      ? Colors.green[500]
                                      : const Color.fromRGBO(
                                          0,
                                          129,
                                          174,
                                          1,
                                        ),
                                ),
                                Text(
                                  type ? 'scan_successful'.tr : "OOPS!",
                                  style: TextStyle(
                                    color: type
                                        ? Colors.green[500]
                                        : const Color.fromRGBO(
                                            0,
                                            129,
                                            174,
                                            1,
                                          ),
                                    fontSize: 25,
                                    fontWeight: FontWeight.w900,
                                  ),
                                )
                              ],
                            ),
                            type
                                ? Column(
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            'tracking_id'.tr,
                                            style: const TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                          Text(
                                            value,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                : Column(
                                    children: [
                                      Text(
                                        'invalid_qr'.tr,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                        'scan_again'.tr,
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                            Column(
                              children: [
                                type
                                    ? ElevatedButton(
                                        onPressed: () {
                                          Get.back();
                                          setContainerNumber(value);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 15,
                                          ),
                                          child: Text(
                                            'confirm_label'.tr,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                          primary: const Color.fromRGBO(
                                            0,
                                            129,
                                            174,
                                            1,
                                          ),
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                                type
                                    ? const SizedBox(
                                        height: 10,
                                      )
                                    : const SizedBox.shrink(),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      child: const Icon(
                                        Icons.qr_code,
                                        size: 50,
                                        color: Color.fromRGBO(
                                          0,
                                          129,
                                          174,
                                          1,
                                        ),
                                      ),
                                      onTap: () {
                                        Get.back();
                                        Get.toNamed('/qr-reader');
                                      },
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      type ? 'Re-scan' : 'Scan Again',
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
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
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
