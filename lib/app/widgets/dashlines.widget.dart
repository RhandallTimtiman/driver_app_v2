import 'package:flutter/material.dart';

class DashLines extends StatelessWidget {
  const DashLines({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      padding: const EdgeInsets.only(left: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const SizedBox(
                height: 3,
              ),
              for (var i = 0; i < 15; i++)
                Column(
                  children: [
                    const SizedBox(
                      height: 4,
                    ),
                    Container(
                      height: 3,
                      width: 3,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}
