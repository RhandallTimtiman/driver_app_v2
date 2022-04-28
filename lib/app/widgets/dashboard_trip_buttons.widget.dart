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
                  TripListModal(
                    title: 'trip_to_accept_label'.tr,
                    showAcceptAll: true,
                    status: 'NEW',
                  ),
                  isScrollControlled: true,
                );
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'trip_to_accept_label'.tr,
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
                  TripListModal(
                    title: 'pending_trips_label'.tr,
                    showAcceptAll: false,
                    status: 'PEN,ONG',
                  ),
                  isScrollControlled: true,
                );
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'pending_trips_label'.tr,
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
