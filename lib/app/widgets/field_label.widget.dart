import 'package:flutter/material.dart';

class FieldLabel extends StatelessWidget {
  final String fieldName;
  final String fieldVaue;

  const FieldLabel({
    Key? key,
    this.fieldName = '',
    this.fieldVaue = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              '$fieldName:',
              style: TextStyle(
                color: Colors.grey[500],
              ),
            ),
          ),
          Expanded(
            child: Text(
              fieldVaue,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
