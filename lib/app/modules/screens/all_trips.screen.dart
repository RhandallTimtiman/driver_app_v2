import 'package:driver_app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:driver_app/app/data/controllers/controllers.dart';

class AllTripsScreen extends StatefulWidget {
  final String type;
  const AllTripsScreen(this.type, {Key? key}) : super(key: key);

  @override
  _AllTripsScreenState createState() => _AllTripsScreenState();
}

class _AllTripsScreenState extends State<AllTripsScreen> {
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
