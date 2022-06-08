import 'package:dotted_border/dotted_border.dart';
import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/data/models/models.dart';
import 'package:driver_app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DocumentGroup extends StatelessWidget {
  final Function addDocument;
  const DocumentGroup({
    Key? key,
    required this.addDocument,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Documents',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          DottedBorder(
            color: Colors.black26,
            strokeWidth: 2.0,
            child: GetBuilder<RouteCompletionController>(
              builder: (_) {
                List<DocumentStates> documentList =
                    _.docGroup.value.documentList;

                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  width: size.width,
                  height: 160,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width,
                      ),
                      child: Row(
                        children: [
                          for (var i = 0; i < documentList.length; i++)
                            DocumentGridRoutecompletion(
                              documents: documentList[i],
                              addDocument: addDocument,
                              index: i,
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
