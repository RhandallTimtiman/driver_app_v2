import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  final double width;
  final double height;
  final Color? color;
  final String image;
  final String title;
  final Function? onClick;

  // ignore: use_key_in_widget_constructors
  const CircularButton({
    this.color,
    required this.width,
    required this.height,
    this.image = '',
    this.onClick,
    this.title = '',
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onClick!(),
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(12),
        width: 120,
        height: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Image(
              image: AssetImage(
                image,
              ),
              width: 30,
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 10,
                color: Colors.white,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
