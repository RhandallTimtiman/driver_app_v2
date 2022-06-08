import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RemarksWidget extends StatelessWidget {
  final TextEditingController controller;
  const RemarksWidget({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(2, 2), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('remarks_label'.tr),
          const SizedBox(
            height: 5,
          ),
          Container(
            margin: EdgeInsets.zero,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black26, width: 1),
              color: Colors.grey[100],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: controller,
                maxLines: 5,
                decoration: const InputDecoration.collapsed(
                    hintText: "Enter your text here"),
              ),
            ),
          ),
          Container(
            width: size.width,
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'note_label'.tr,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),
                Text(
                  'alert_admin_label'.tr,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
