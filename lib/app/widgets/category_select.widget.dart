import 'package:driver_app/app/data/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategorySelect extends StatelessWidget {
  final String category;
  final Function setCategory;
  final List<DocumentCategory> categoryList;
  const CategorySelect({
    Key? key,
    required this.category,
    required this.setCategory,
    required this.categoryList,
  }) : super(key: key);

  void _modalBottomSheetMenu(context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Choose Category'),
        actions: <Widget>[
          for (var i = 0; i < categoryList.length; i++)
            CupertinoActionSheetAction(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  categoryList[i].description,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                  ),
                ),
              ),
              onPressed: () {
                setCategory(
                  categoryList[i],
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
          border: Border.all(
            color: Colors.black26,
          ),
        ),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 20,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                category.isEmpty ? 'Add Category' : category,
                style: TextStyle(
                  fontSize: 12,
                  color: category.isEmpty ? Colors.grey : Colors.black,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            const Icon(
              Icons.arrow_drop_down,
            )
          ],
        ),
      ),
    );
  }
}
