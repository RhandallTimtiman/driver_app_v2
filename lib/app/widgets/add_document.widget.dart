import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddDocument extends StatefulWidget {
  final int? index;
  const AddDocument({
    Key? key,
    this.index,
  }) : super(key: key);

  @override
  State<AddDocument> createState() => _AddDocumentState();
}

class _AddDocumentState extends State<AddDocument> {
  @override
  void initState() {
    Get.find<RouteCompletionController>().getDocumentCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return DraggableScrollableSheet(
      expand: true,
      initialChildSize: 1,
      minChildSize: 0.2,
      maxChildSize: 1.0,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Container(
            margin: const EdgeInsets.fromLTRB(10, 30, 10, 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
            ),
            padding: const EdgeInsets.only(top: 30),
            width: double.infinity,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: size.height - 40,
              ),
              child: GetBuilder<RouteCompletionController>(builder: (_) {
                return Column(
                  children: [
                    Stack(
                      children: [
                        Positioned(
                          left: 30,
                          child: GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: const Icon(
                              Icons.arrow_back,
                            ),
                          ),
                        ),
                        const Center(
                          child: Text(
                            'Add Trip Documents',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    _.documentCategories.isNotEmpty
                        ? CategorySelect(
                            category: _.docs.value.category != null &&
                                    _.docs.value.category?.description != null
                                ? _.docs.value.category!.description
                                : '',
                            setCategory: _.setCategory,
                            categoryList: _.documentCategories,
                          )
                        : Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.white,
                              border: Border.all(color: Colors.black26),
                            ),
                            padding: const EdgeInsets.all(4),
                            child: const Center(
                              child: CircularProgressIndicator(
                                value: null,
                                strokeWidth: 7.0,
                                backgroundColor: Color.fromRGBO(
                                  244,
                                  162,
                                  64,
                                  1,
                                ),
                              ),
                            ),
                          ),
                    UploadButtons(
                      addSignature:
                          Get.find<RouteCompletionController>().addSignature,
                    ),
                    if (_.docs.value.attachedFile != null)
                      AttachedFile(
                        type: _.docs.value.attachedFileType!,
                      ),
                    if (_.docs.value.imageList!.isNotEmpty)
                      const AttachedPhotos(),
                    if (_.docs.value.signatureData != null)
                      SignatureImage(
                        signature: _.docs.value.signatureData!,
                      ),
                    if ((_.docs.value.attachedFile != null ||
                            _.docs.value.imageList!.isNotEmpty ||
                            _.docs.value.signatureData != null) &&
                        _.docs.value.category?.documentCategoryId != null)
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: RaisedGradientButton(
                            width: 250,
                            child: const Text(
                              'Add',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: <Color>[
                                Color.fromRGBO(0, 172, 235, 1),
                                Color.fromRGBO(0, 209, 255, 1),
                              ],
                            ),
                            onPressed: () {
                              Get.find<RouteCompletionController>()
                                  .addTripDocuments(widget.index);
                            }),
                      ),
                  ],
                );
              }),
            ),
          ),
        );
      },
    );
  }
}
