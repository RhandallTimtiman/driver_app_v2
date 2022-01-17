import 'package:driver_app/app/data/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReasonWidget extends StatelessWidget {
  final List<ReportIssue> reasonList;

  final ReportIssue reason;

  final Function setReason;

  const ReasonWidget({
    Key? key,
    required this.reasonList,
    required this.reason,
    required this.setReason,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              'reason_label'.tr,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            ),
          ),
          GestureDetector(
            onTap: () {
              final act = CupertinoActionSheet(
                title: Text('select_reason_label'.tr),
                actions: [
                  for (var i = 0; i < reasonList.length; i++)
                    CupertinoActionSheetAction(
                      child: Text(reasonList[i].description,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          )),
                      onPressed: () {
                        setReason(reasonList[i]);
                        Get.back();
                      },
                    )
                ],
                cancelButton: CupertinoActionSheetAction(
                  child: Text('cancel_label'.tr),
                  onPressed: () {
                    Get.back();
                  },
                ),
              );
              showCupertinoModalPopup(
                context: context,
                builder: (BuildContext context) => act,
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
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
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      reason.description,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  const Icon(Icons.arrow_drop_down)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
