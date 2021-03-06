import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/data/models/models.dart';
import 'package:driver_app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodayTrips extends StatefulWidget {
  const TodayTrips({Key? key}) : super(key: key);

  @override
  _TodayTripsState createState() => _TodayTripsState();
}

class _TodayTripsState extends State<TodayTrips> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final TodayTripsController _todayTripController = Get.find();

  openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  Future<void> pullRefresh() async {
    _todayTripController.getTripList();
  }

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _todayTripController.getTripList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: MainAppBar(
        title: Text(
          'today_trip_label'.tr,
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
            GetBuilder<TodayTripsController>(
              builder: (_) => SearchField(
                controller: _.todayTripsSearchController,
                hint: 'search_trip_input_label'.tr,
                clearEvent: _.clearSearch,
                onChangeEvent: _.searchTrips,
                searchValue: _.todayTripsSearchController.text,
                prefixIcon: const Icon(
                  Icons.search,
                  size: 14,
                ),
              ),
            ),
            Expanded(
              child: GetX<TodayTripsController>(
                builder: (_) {
                  if (_.loading.value) {
                    return const LoaderWidget();
                  } else {
                    if (_.todayTripList.isEmpty) {
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
                        itemCount: _todayTripController.todayTripList.length,
                        itemBuilder: (context, index) {
                          Trip trip = _.todayTripList[index];
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
      ),
    );
  }
}
