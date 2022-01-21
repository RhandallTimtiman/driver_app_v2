import 'package:flutter/material.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white12,
      child: SizedBox(
        height: 100,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                CircularProgressIndicator(
                  strokeWidth: 7.0,
                  backgroundColor: Color.fromRGBO(244, 162, 64, 1),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Please wait...",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
