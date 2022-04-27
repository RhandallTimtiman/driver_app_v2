import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TripListFilter extends StatefulWidget {
  const TripListFilter({Key? key}) : super(key: key);

  @override
  State<TripListFilter> createState() => _TripListFilterState();
}

class _TripListFilterState extends State<TripListFilter> {
  String filter = 'today';
  final TripController _tripController = Get.find();

  void _setFilter(String value) {
    setState(() {
      filter = value;
    });
    _tripController.getTripList(type: 'NEW', filter: value);
    _tripController.clearSearchValue();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 8.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () => _setFilter('today'),
            child: Text(
              'TODAY',
              style: TextStyle(
                color: filter == 'today'
                    ? const Color.fromRGBO(0, 166, 227, 1)
                    : Colors.black54,
                fontWeight:
                    filter == 'today' ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ),
          Container(
            width: 1,
            height: 20,
            color: Colors.black54,
          ),
          InkWell(
            onTap: () => _setFilter('upcoming'),
            child: Text(
              'UPCOMING',
              style: TextStyle(
                color: filter == 'upcoming'
                    ? const Color.fromRGBO(0, 166, 227, 1)
                    : Colors.black54,
                fontWeight:
                    filter == 'upcoming' ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ),
          Container(
            width: 1,
            height: 20,
            color: Colors.black54,
          ),
          InkWell(
            onTap: () => _setFilter('missed'),
            child: Text(
              'MISSED',
              style: TextStyle(
                color: filter == 'missed'
                    ? const Color.fromRGBO(0, 166, 227, 1)
                    : Colors.black54,
                fontWeight:
                    filter == 'missed' ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ),
          Container(
            width: 1,
            height: 20,
            color: Colors.black54,
          ),
          InkWell(
            onTap: () => _setFilter('all'),
            child: Text(
              'ALL',
              style: TextStyle(
                color: filter == 'all'
                    ? const Color.fromRGBO(0, 166, 227, 1)
                    : Colors.black54,
                fontWeight: filter == 'all' ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
