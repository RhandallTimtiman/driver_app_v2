import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/data/models/models.dart';
import 'package:driver_app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllTripsScreen extends StatefulWidget {
  const AllTripsScreen({Key? key}) : super(key: key);

  @override
  _AllTripsScreenState createState() => _AllTripsScreenState();
}

class _AllTripsScreenState extends State<AllTripsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final AllTripsController _allTripController = Get.find();

  openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  Future<void> pullRefresh() async {
    _allTripController.getTripList(isPulled: true);
    return Future.delayed(
      const Duration(seconds: 2),
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _allTripController.getTripList();
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
          'all_trip_label'.tr,
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
              controller: _allTripController.allTripsSearchController,
              hint: 'search_trip_input_label'.tr,
              clearEvent: () {
                _allTripController.allTripsSearchController.text = '';
              },
              onChangeEvent: _allTripController.searchTrips,
              searchValue: _allTripController.allTripsSearchController.text,
              prefixIcon: const Icon(
                Icons.search,
                size: 14,
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: pullRefresh,
                child: GetX<AllTripsController>(
                  builder: (_) {
                    if (_.isLoaded.value) {
                      return const LoaderWidget();
                    } else {
                      if (_.tripList.isEmpty) {
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
                          itemCount: _allTripController.tripList.length,
                          itemBuilder: (context, index) {
                            Trip trip = _.tripList[index];
                            return TripCard(trip: trip);
                          },
                        );
                      }
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
