import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final String icon;
  final String name;
  final Function onTap;
  final int width;

  const DrawerItem({
    Key? key,
    required this.icon,
    required this.name,
    required this.onTap,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Row(
              children: [
                Image(
                  image: AssetImage(
                    icon,
                  ),
                  width: width.toDouble(),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            color: Colors.white70,
          ),
        ],
      ),
    );
  }
}
