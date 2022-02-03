import 'package:flutter/material.dart';

class RowDivider extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const RowDivider(
      {Key? key, required this.label, required this.value, required this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        const SizedBox(
          width: 20,
          child: Text(':'),
        ),
        Flexible(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ],
    );
  }
}
