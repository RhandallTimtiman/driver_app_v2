import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageInput extends StatelessWidget {
  const MessageInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      child: TextField(
        style: const TextStyle(
          fontSize: 14,
        ),
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.grey[400]),
            hintText: 'hint_enter_message'.tr,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.black38,
                width: 1,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 3,
              ),
            ),
            suffixIcon: IconButton(
              // ignore: avoid_print
              onPressed: () => print('Sent'),
              icon: const Icon(
                Icons.send,
              ),
            )),
      ),
    );
  }
}
