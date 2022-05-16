import 'package:driver_app/app/data/models/models.dart';
import 'package:flutter/material.dart';

class ContainerDetailsWidget extends StatelessWidget {
  final ContainerInfoList container;

  const ContainerDetailsWidget({Key? key, required this.container})
      : super(key: key);
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
              'Container Information',
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      width: 120,
                      child: Text(
                        'Total Volume ',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                      child: Text(':'),
                    ),
                    Flexible(
                      child: Text(
                        container.totalVolume ?? '',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      width: 120,
                      child: Text(
                        'Special Condition ',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                      child: Text(':'),
                    ),
                    Flexible(
                      child: Text(
                        container.specialCondition ?? '',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      width: 120,
                      child: Text(
                        'Instructions / Others',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                      child: Text(':'),
                    ),
                    Flexible(
                      child: Text(
                        container.instructionsOthers ?? '',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
