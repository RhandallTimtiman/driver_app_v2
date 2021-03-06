import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:driver_app/app/widgets/widgets.dart';
import 'package:get/get.dart';

class PendingTrips extends StatefulWidget {
  const PendingTrips({Key? key}) : super(key: key);

  @override
  _PendingTripsState createState() => _PendingTripsState();
}

class _PendingTripsState extends State<PendingTrips> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final PendingTripsController _pendingTripController = Get.find();

  openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  Future<void> pullRefresh() async {
    _pendingTripController.getTripList();
    return Future.delayed(
      const Duration(seconds: 2),
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _pendingTripController.getTripList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: MainAppBar(
        title: Text(
          'pending_trip_label'.tr,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        onMenuPress: () => openDrawer(),
        showOnlineButton: true,
      ),
      drawer: const MainDrawer(),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GetBuilder<PendingTripsController>(
              builder: (_) => SearchField(
                controller: _.pendingTripsSearchController,
                hint: 'search_trip_input_label'.tr,
                clearEvent: _.clearSearch,
                onChangeEvent: _.searchTrips,
                searchValue: _.pendingTripsSearchController.text,
                prefixIcon: const Icon(
                  Icons.search,
                  size: 14,
                ),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: pullRefresh,
                child: GetX<PendingTripsController>(
                  builder: (_) {
                    if (_.loading.value) {
                      return const LoaderWidget();
                    } else {
                      if (_.pendingTripList.isEmpty) {
                        return Center(
                          child: Text(
                            'no_trips_label'.tr,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.black26),
                          ),
                        );
                      } else {
                        return ListView.builder(
                          itemCount:
                              _pendingTripController.pendingTripList.length,
                          itemBuilder: (context, index) {
                            Trip trip = _.pendingTripList[index];
                            return TripCard(trip: trip);
                          },
                        );
                      }
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
