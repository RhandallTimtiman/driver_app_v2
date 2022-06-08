import 'package:driver_app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';

class RouteDetails extends StatelessWidget {
  final OriginDestinationWidget child;

  const RouteDetails({Key? key, required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      elevation: 3,
      child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black26,
                  width: 1,
                ),
              ),
            ),
            child: const Text(
              'Route Details',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: child,
          ),
        ],
      ),
    );
  }
}
