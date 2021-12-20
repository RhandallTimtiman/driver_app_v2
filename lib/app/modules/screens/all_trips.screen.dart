import 'package:driver_app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:driver_app/app/data/controllers/controllers.dart';

class AllTrips extends StatefulWidget {
  final String type;
  const AllTrips(this.type, {Key? key}) : super(key: key);

  @override
  _AllTripsState createState() => _AllTripsState();
}

class _AllTripsState extends State<AllTrips> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: MainAppBar(
        title: Text(
          widget.type.tr,
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
            SearchField(
              controller: TripController.to.searchController,
              hint: 'search_trip_input_label'.tr,
              clearEvent: () {
                TripController.to.searchController.text = '';
              },
              onChangeEvent: (value) {},
              searchValue: TripController.to.searchController.text,
              prefixIcon: const Icon(
                Icons.search,
                size: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
