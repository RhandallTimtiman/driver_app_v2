import 'package:driver_app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardTripButton extends StatelessWidget {
  const DashboardTripButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                Get.bottomSheet(
                  const TripListModal(
                    title: 'Trips to Accept',
                    showAcceptAll: true,
                  ),
                  isScrollControlled: true,
                );
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                child: const Text(
                  'Trips to Accept',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
            child: VerticalDivider(
              width: 2,
              thickness: 1,
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                Get.bottomSheet(
                  const TripListModal(
                    title: 'Pending Trips',
                    showAcceptAll: true,
                  ),
                  isScrollControlled: true,
                );
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                child: const Text(
                  'Pending Trips',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
