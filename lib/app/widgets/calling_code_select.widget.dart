import 'package:driver_app/app/data/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CallingCodeSelect extends StatelessWidget {
  final String callingCode;
  final Function setCallingCode;
  final List<CallingCode> callingCodeList;
  const CallingCodeSelect({
    Key? key,
    required this.callingCode,
    required this.setCallingCode,
    required this.callingCodeList,
  }) : super(key: key);

  void _modalBottomSheetMenu(context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Choose Prefix'),
        actions: <Widget>[
          for (var i = 0; i < callingCodeList.length; i++)
            CupertinoActionSheetAction(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  callingCodeList[i].callingCode,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                  ),
                ),
              ),
              onPressed: () {
                setCallingCode(
                  callingCodeList[i].callingCode.toString(),
                );
                Get.back();
              },
            ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: const Text('Cancel'),
          isDestructiveAction: true,
          onPressed: () {
            Get.back();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _modalBottomSheetMenu(context);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          border: Border.all(color: Colors.black26),
        ),
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Expanded(
              child: Text(
                callingCode,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            const Icon(
              Icons.arrow_drop_down,
            ),
          ],
        ),
      ),
    );
  }
}
