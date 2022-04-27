import 'package:flutter/material.dart';

class LoaderWidget extends StatelessWidget {
  final String message;
  final Color messageColor;
  const LoaderWidget({
    Key? key,
    this.message = "Please wait ...",
    this.messageColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              style: TextStyle(
                color: messageColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
