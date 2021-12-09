import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class TripList extends StatefulWidget {
  final String status;
  const TripList({Key? key, this.status = 'New'}) : super(key: key);

  @override
  _TripListState createState() => _TripListState();
}

class _TripListState extends State<TripList> {
  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      TripController.to.clearTrips();
    });
    super.initState();
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
          SearchField(
            controller: TripController.to.searchController,
            hint: 'Search Transactions',
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
    );
  }
}
