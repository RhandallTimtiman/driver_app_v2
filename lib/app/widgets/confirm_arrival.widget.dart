import 'package:driver_app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmArrival extends StatelessWidget {
  final String title;
  final String message;
  final String routeName;
  final String address;
  final String instruction;
  final int acquiredTruckingServiceId;
  final String status;
  final bool isOrigin;
  final Function callback;
  const ConfirmArrival({
    Key? key,
    required this.title,
    required this.message,
    required this.routeName,
    required this.address,
    this.instruction = '-',
    required this.acquiredTruckingServiceId,
    required this.status,
    required this.isOrigin,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      constraints: const BoxConstraints(
        maxWidth: 500,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Row(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Color.fromRGBO(4, 164, 223, 1),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Image(
                      image: AssetImage('assets/icons/fleet-icon.png'),
                      width: 35,
                    )
                  ],
                ),
              ),
              Positioned(
                top: -3,
                right: -3,
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: const Icon(
                    Icons.cancel,
                    size: 35,
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
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      routeName,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      address,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                      style: const TextStyle(fontSize: 14),
                    ),
                    Text(
                      instruction,
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                      ),
                      child: RaisedGradientButton(
                        width: 100,
                        child: const Text(
                          'No',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            Color.fromRGBO(0, 172, 235, 1),
                            Color.fromRGBO(0, 209, 255, 1),
                          ],
                        ),
                        onPressed: () => Get.back(),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                      ),
                      child: RaisedGradientButton(
                        width: 100,
                        child: const Text(
                          'Yes',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            Color.fromRGBO(0, 172, 235, 1),
                            Color.fromRGBO(0, 209, 255, 1),
                          ],
                        ),
                        onPressed: () {
                          Get.back();
                          callback(
                            acquiredTruckingServiceId,
                            status,
                            isOrigin,
                          );
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
