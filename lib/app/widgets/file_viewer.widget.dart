import 'package:driver_app/app/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class FileViewerScreen extends StatelessWidget {
  final String documentCategory;

  final String dateSubmitted;

  final List<TripDocument> fileUploads;

  final List<TripDocument> imageUploads;

  // final List<TripDocument> signatureUploads;

  const FileViewerScreen({
    Key? key,
    required this.documentCategory,
    required this.dateSubmitted,
    required this.fileUploads,
    required this.imageUploads,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    void openUrl(url) async {
      Uri _url = Uri.parse(url);
      if (await canLaunchUrl(_url)) {
        await launchUrl(
          _url,
          mode: LaunchMode.inAppWebView,
        );
      } else {
        throw 'Could not launch $url';
      }
    }

    return DraggableScrollableSheet(
      expand: true,
      initialChildSize: 1.0,
      minChildSize: 0.2,
      maxChildSize: 1.0,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Container(
            height: size.height,
            margin: const EdgeInsets.fromLTRB(10, 30, 10, 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.white,
            ),
            padding: const EdgeInsets.only(top: 30),
            width: double.infinity,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - 35,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Positioned(
                          left: 30,
                          child: GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: const Icon(Icons.arrow_back),
                          ),
                        ),
                        const Center(
                          child: Text(
                            'Attachments',
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
                      height: 15,
                    ),
                    Center(
                      child: SizedBox(
                        width: (size.width / 2) + 50,
                        child: Text(
                          documentCategory,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black87,
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 2,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Text(
                        dateSubmitted,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    fileUploads.isNotEmpty
                        ? Text(
                            'attached_file'.tr,
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        : const SizedBox.shrink(),
                    fileUploads.isNotEmpty
                        ? const SizedBox(
                            height: 10,
                          )
                        : const SizedBox.shrink(),
                    fileUploads.isNotEmpty
                        ? ListView.builder(
                            itemCount: fileUploads.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext ctx, int index) {
                              return GestureDetector(
                                onTap: () {
                                  openUrl(
                                    fileUploads[index].link,
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    bottom: 5,
                                  ),
                                  child: Text(
                                    fileUploads[index].fileName,
                                    style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        : const SizedBox.shrink(),
                    const SizedBox(
                      height: 20,
                    ),
                    imageUploads.isNotEmpty
                        ? Text(
                            'photos_label'.tr,
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          )
                        : const SizedBox.shrink(),
                    imageUploads.isNotEmpty
                        ? const SizedBox(
                            height: 10,
                          )
                        : const SizedBox.shrink(),
                    imageUploads.isNotEmpty
                        ? Row(
                            children: [
                              const Icon(
                                Icons.arrow_left,
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      for (var i = 0;
                                          i < imageUploads.length;
                                          i++)
                                        Stack(
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  openUrl(
                                                    imageUploads[i].link,
                                                  );
                                                },
                                                child: Card(
                                                  elevation: 2,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  margin: EdgeInsets.zero,
                                                  color: Colors.white,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    child: ConstrainedBox(
                                                      constraints:
                                                          const BoxConstraints(
                                                              minWidth: 200),
                                                      child: Image.network(
                                                        imageUploads[i].link!,
                                                        height: 140,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              const Icon(Icons.arrow_right),
                            ],
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
