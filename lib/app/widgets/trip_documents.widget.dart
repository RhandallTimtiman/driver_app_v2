import 'package:driver_app/app/data/models/models.dart';
import 'package:driver_app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import "package:collection/collection.dart";

class TripAttachments extends StatelessWidget {
  final List<TripDocument> tripDocuments;

  const TripAttachments({Key? key, required this.tripDocuments})
      : super(key: key);

  Widget getDocumentWidgets(Map<String, List<TripDocument>> documents) {
    List<Widget> list = [];
    documents.forEach((key, value) {
      list.add(
        DocumentGrid(
          tripDocuments: value,
        ),
      );
    });
    return Row(children: list);
  }

  @override
  Widget build(BuildContext context) {
    Map<String, List<TripDocument>> groupedDocuments =
        groupBy(tripDocuments, (TripDocument obj) => obj.documentCategoryId);
    var size = MediaQuery.of(context).size;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      elevation: 3,
      child: Column(
        children: [
          Container(
            width: size.width,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: const [
                Image(
                  image: AssetImage('assets/icons/attachment.png'),
                  width: 20,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Attachments',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            width: MediaQuery.of(context).size.width,
            height: 160,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width,
                ),
                child: getDocumentWidgets(groupedDocuments),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
