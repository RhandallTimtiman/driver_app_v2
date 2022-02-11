import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:driver_app/app/widgets/widgets.dart';
import 'package:get/get.dart';

class NewTrips extends StatefulWidget {
  const NewTrips({Key? key}) : super(key: key);

  @override
  _NewTripsState createState() => _NewTripsState();
}

class _NewTripsState extends State<NewTrips> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final NewTripsController _newTripController = Get.find();

  openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  Future<void> pullRefresh() async {
    _newTripController.getTripList();
    return Future.delayed(
      const Duration(seconds: 2),
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _newTripController.getTripList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: MainAppBar(
        title: Text(
          'new_trip_label'.tr,
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
        height: size.height - 100,
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            SearchField(
              controller: _newTripController.newTripsSearchController,
              hint: 'search_trip_input_label'.tr,
              clearEvent: () {
                _newTripController.newTripsSearchController.text = '';
              },
              onChangeEvent: _newTripController.searchTrips,
              searchValue: _newTripController.newTripsSearchController.text,
              prefixIcon: const Icon(
                Icons.search,
                size: 14,
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: pullRefresh,
                child: GetX<NewTripsController>(
                  builder: (_) {
                    if (_.loading.value) {
                      return const LoaderWidget();
                    } else {
                      if (_.newTripList.isEmpty) {
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
                          itemCount: _newTripController.newTripList.length,
                          itemBuilder: (context, index) {
                            Trip trip = _.newTripList[index];
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
