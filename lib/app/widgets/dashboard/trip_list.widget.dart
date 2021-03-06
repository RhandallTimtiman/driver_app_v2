import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/data/models/models.dart';
import 'package:driver_app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TripList extends StatefulWidget {
  final String status;
  const TripList({Key? key, required this.status}) : super(key: key);

  @override
  _TripListState createState() => _TripListState();
}

class _TripListState extends State<TripList> {
  final TripController _tripController = Get.find();

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _tripController.getTripList(
        type: widget.status,
        filter: widget.status == 'NEW' ? 'today' : '',
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    _tripController.searchController.text = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var filter = "today";
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GetBuilder<TripController>(
            builder: (_) => SearchField(
              controller: _.searchController,
              hint: 'search_trip_input_label'.tr,
              clearEvent: _.clearSearchValue,
              onChangeEvent: _.filterTripListBySearch,
              searchValue: _.searchController.text,
              prefixIcon: const Icon(
                Icons.search,
                size: 14,
              ),
            ),
          ),
          widget.status == 'NEW'
              ? const TripListFilter()
              : const SizedBox.shrink(),
          Expanded(
            child: GetBuilder<TripController>(
              builder: (_) {
                if (_.loading.value) {
                  return const LoaderWidget();
                } else {
                  if (_.tripList.isEmpty) {
                    return Center(
                      child: Text(
                        'no_trips_label'.tr,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.black26,
                        ),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: _tripController.tripList.length,
                      itemBuilder: (context, index) {
                        Trip trip = _.tripList[index];
                        return TripCard(trip: trip);
                      },
                    );
                  }
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
