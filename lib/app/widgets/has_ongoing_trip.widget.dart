import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HasOnGoingTrip extends StatelessWidget {
  final Trip trip;
  const HasOnGoingTrip({
    Key? key,
    required this.trip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.cancel,
                color: Colors.redAccent,
                size: 100,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'ongoing_trip_label'.tr,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'ongoing_trip_spiel_label'.tr,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  child: Text(
                    'go_to_current_trip_label'.tr,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromRGBO(
                        0,
                        166,
                        227,
                        1,
                      ),
                    ),
                  ),
                  onPressed: () {
                    Get.back();
                    Get.find<TripController>().handleCurrentTrip(trip: trip);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
