import 'package:cached_network_image/cached_network_image.dart';
import 'package:driver_app/app/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class DriverCard extends StatelessWidget {
  final Driver driver;

  const DriverCard({Key? key, required this.driver}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 500,
      ),
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3), //
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: SizedBox(
                height: 80,
                width: 80,
                child: CachedNetworkImage(
                  imageUrl: driver.driverImage,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => Shimmer.fromColors(
                    child: const SizedBox(
                      height: 80,
                      width: 80,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    baseColor: Colors.grey.shade300,
                    enabled: true,
                    highlightColor: Colors.grey.shade100,
                    period: const Duration(milliseconds: 1000),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 16.0, left: 16.0, bottom: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'driver_card_name'.tr,
                        style: const TextStyle(fontSize: 12),
                      ),
                      Text(
                        '${driver.firstName} ${driver.lastName}',
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'driver_card_contact'.tr,
                        style: const TextStyle(fontSize: 12),
                      ),
                      Expanded(
                        child: Text(
                          '${driver.mobileNumberPrefix}${driver.mobileNumber}',
                          style: const TextStyle(fontWeight: FontWeight.w700),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
