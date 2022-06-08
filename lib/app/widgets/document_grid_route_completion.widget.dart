import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DocumentGridRoutecompletion extends StatelessWidget {
  final Function addDocument;
  final DocumentStates documents;
  final int index;

  const DocumentGridRoutecompletion(
      {Key? key,
      required this.documents,
      required this.addDocument,
      required this.index})
      : super(key: key);

  _addDocuments() {
    Get.find<RouteCompletionController>().setDocs(documents);
    addDocument(index);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => _addDocuments(),
      child: Column(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              documents.category!.description,
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
                if (documents.attachedFile != null)
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      margin: const EdgeInsets.all(2),
                      width: double.infinity,
                      height: double.infinity,
                      child: documents.attachedFileType != 'png' &&
                              documents.attachedFileType != 'jpg' &&
                              documents.attachedFileType != 'jpeg'
                          ? Image(
                              image: documents.attachedFileType == 'doc' ||
                                      documents.attachedFileType == 'docx'
                                  ? const AssetImage(
                                      'assets/images/img-docs.png')
                                  : documents.attachedFileType == 'xls' ||
                                          documents.attachedFileType == 'xlsx'
                                      ? const AssetImage(
                                          'assets/images/img-excel.png')
                                      : const AssetImage(
                                          'assets/images/img-pdf.png'),
                              fit: BoxFit.contain,
                              height: 140,
                            )
                          : Image.file(
                              documents.attachedFile!,
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                    ),
                    flex: 1,
                  ),
                if (documents.imageList!.isNotEmpty ||
                    documents.signatureData != null)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (documents.imageList!.isNotEmpty)
                          Expanded(
                            child: SizedBox(
                              width: size.width,
                              child: GridView.builder(
                                scrollDirection: Axis.horizontal,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: documents.attachedFile == null
                                      ? 1
                                      : documents.imageList!.length < 3
                                          ? 1
                                          : 2,
                                  crossAxisSpacing: 2,
                                  mainAxisSpacing: 2,
                                  childAspectRatio:
                                      documents.imageList!.length < 2 ? .3 : .7,
                                ),
                                itemBuilder: (_, index) => Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Container(
                                    color: Colors.white,
                                    child: Image.file(
                                      documents.imageList![index],
                                      fit: BoxFit.cover,
                                      alignment: Alignment.center,
                                    ),
                                  ),
                                ),
                                itemCount: documents.imageList!.length,
                              ),
                            ),
                            flex: documents.imageList!.length < 3 ? 1 : 2,
                          ),
                        if (documents.signatureData != null)
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(2),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                color: Colors.white,
                                child: Image.memory(
                                  documents.signatureData!,
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
            DateFormat('MMM dd, yyyy hh:mm a').format(DateTime.now()),
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
