import 'package:cached_network_image/cached_network_image.dart';
import 'package:driver_app/app/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:shimmer/shimmer.dart';

class VehicleCard extends StatelessWidget {
  final Vehicle vehicle;
  final bool isSelected;

  const VehicleCard({
    Key? key,
    required this.vehicle,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
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
        crossAxisAlignment: CrossAxisAlignment.center,
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
                  imageUrl: vehicle.imageUrl,
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
                    period: const Duration(
                      milliseconds: 1000,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Wrap(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'vehicle_card_brand'.tr,
                        style: const TextStyle(fontSize: 12),
                      ),
                      Expanded(
                        child: Text(
                          vehicle.brand,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'vehicle_card_model'.tr,
                        style: const TextStyle(fontSize: 12),
                      ),
                      Expanded(
                        child: Text(
                          vehicle.model,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'vehicle_card_plate'.tr,
                        style: const TextStyle(fontSize: 12),
                      ),
                      Text(
                        vehicle.plateNumber,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          isSelected
              ? const Image(
                  image: AssetImage('assets/icons/check.png'),
                  width: 25,
                )
              : const SizedBox(
                  width: 25,
                )
        ],
      ),
    );
  }
}
