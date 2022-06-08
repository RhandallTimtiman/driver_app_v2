import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AcceptAllTripModal extends StatelessWidget {
  const AcceptAllTripModal({Key? key}) : super(key: key);

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
                  children: const [
                    Text(
                      'Accept All Trip',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromRGBO(3, 127, 170, 1),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
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
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Are you sure you would like to',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Accept All Trip',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'requests?',
                      style: TextStyle(
                        fontSize: 18,
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
                          Get.find<TripController>().acceptAllTrip(context);
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
