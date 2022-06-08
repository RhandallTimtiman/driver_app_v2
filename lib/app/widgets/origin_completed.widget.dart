import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OriginCompleted extends StatelessWidget {
  const OriginCompleted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GetBuilder<CurrentTripController>(
      builder: (_) {
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
                  const SizedBox(
                    height: 40,
                  ),
                  Positioned(
                    top: -3,
                    right: -3,
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: Icon(
                        Icons.cancel,
                        size: 30,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                ],
              ),
              const Image(
                image: AssetImage('assets/icons/fleet-icon.png'),
                width: 80,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 30.0,
                ),
                child: Text(
                  'proceed_to'.tr,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14),
                child: Text(
                  'Destination: ${_.currentTrip.value.trip.destination.address}',
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                _.currentTrip.value.trip.destination.instruction ?? '--',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 20,
                ),
                child: RaisedGradientButton(
                  width: 120,
                  child: const Text(
                    'OK',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
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
            ],
          ),
        );
      },
    );
  }
}
