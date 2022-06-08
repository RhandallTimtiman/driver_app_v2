import 'package:driver_app/app/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'file_viewer.widget.dart';

class DocumentGrid extends StatelessWidget {
  final List<TripDocument> tripDocuments;

  const DocumentGrid({Key? key, required this.tripDocuments}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var fileUploads =
        tripDocuments.where((doc) => doc.documentTypeId == DocumentTypeId.A);
    var imageUploads =
        tripDocuments.where((doc) => doc.documentTypeId == DocumentTypeId.P);
    var signature =
        tripDocuments.where((doc) => doc.documentTypeId == DocumentTypeId.S);
    var category = tripDocuments.where(
      (doc) => doc.documentCategoryName != '',
    );
    var date = tripDocuments.where(
      (doc) => doc.dateSubmission != null,
    );

    var dateSubmission = DateFormat('MMM dd, yyyy hh:mm a').format(
      date.first.dateSubmission!.toLocal(),
    );

    ImageProvider displayImage() {
      ImageProvider<Object> file;
      if (fileUploads.first.link != null) {
        if ((fileUploads.first.fileName.split(".").last == 'png' ||
            fileUploads.first.fileName.split(".").last == 'jpg' ||
            fileUploads.first.fileName.split(".").last == 'jpeg')) {
          file = NetworkImage(
            fileUploads.first.link!,
          );
        } else {
          file = AssetImage(
              fileUploads.first.fileName.split(".").last == 'doc' ||
                      fileUploads.first.fileName.split(".").last == 'docx'
                  ? 'assets/images/img-docs.png'
                  : fileUploads.first.fileName.split(".").last == 'xls' ||
                          fileUploads.first.fileName.split(".").last == 'xlsx'
                      ? 'assets/images/img-excel.png'
                      : 'assets/images/img-pdf.png');
        }
      } else {
        file = const AssetImage('assets/images/empty.jpg');
      }
      return file;
    }

    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Get.bottomSheet(
          FileViewerScreen(
            documentCategory: category.first.documentCategoryName,
            dateSubmitted: dateSubmission,
            imageUploads: [...imageUploads, ...signature],
            fileUploads: fileUploads.toList(),
          ),
          isScrollControlled: true,
        );
      },
      child: Column(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              category.isNotEmpty ? category.first.documentCategoryName : '',
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              maxLines: 1,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            color: Theme.of(context).primaryColor,
            width: 150,
            height: 100,
            padding: const EdgeInsets.all(4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (fileUploads.isNotEmpty)
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      margin: const EdgeInsets.all(2),
                      width: double.infinity,
                      height: double.infinity,
                      child: Image(
                        image: displayImage(),
                        fit: fileUploads.first.fileName.split(".").last ==
                                    'png' ||
                                fileUploads.first.fileName.split(".").last ==
                                    'jpg' ||
                                fileUploads.first.fileName.split(".").last ==
                                    'jpeg'
                            ? BoxFit.cover
                            : BoxFit.contain,
                      ),
                    ),
                    flex: 1,
                  ),
                if (imageUploads.isNotEmpty || signature.isNotEmpty)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (imageUploads.isNotEmpty)
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(2),
                              child: SizedBox(
                                width: size.width,
                                child: GridView.builder(
                                  scrollDirection: Axis.horizontal,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: fileUploads.isEmpty
                                        ? 1
                                        : imageUploads.length < 3
                                            ? 1
                                            : 2,
                                    crossAxisSpacing: 2,
                                    mainAxisSpacing: 2,
                                    childAspectRatio: imageUploads.isEmpty
                                        ? .3
                                        : fileUploads.isEmpty
                                            ? .3
                                            : .7,
                                  ),
                                  itemBuilder: (_, index) => Container(
                                    color: Colors.white,
                                    child: Image(
                                      image: NetworkImage(
                                        imageUploads.toList()[index].link!,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  itemCount: imageUploads.length,
                                ),
                              ),
                            ),
                            flex: 2,
                          ),
                        if (signature.isNotEmpty)
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(2),
                              child: Container(
                                width: size.width,
                                color: Colors.white,
                                child: Image(
                                  image: NetworkImage(signature.first.link!),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            flex: 1,
                          ),
                      ],
                    ),
                    flex: 1,
                  )
              ],
            ),
          ),
          Text(
            dateSubmission.toString(),
            style: const TextStyle(
              color: Colors.black45,
              fontSize: 8,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
