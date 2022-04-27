import 'package:flutter/material.dart';

class BackgroundLoader extends StatelessWidget {
  final String message;
  const BackgroundLoader({
    Key? key,
    this.message = "Please wait ...",
  }) : super(key: key);

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
              children: [
                const CircularProgressIndicator(
                  strokeWidth: 7.0,
                  backgroundColor: Color.fromRGBO(244, 162, 64, 1),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
