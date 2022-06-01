import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AttachedFile extends StatelessWidget {
  final String type;

  const AttachedFile({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Attached File',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 5,
          ),
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(
                  10.0,
                ),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      10.0,
                    ),
                  ),
                  margin: EdgeInsets.zero,
                  color: Colors.white,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      10.0,
                    ),
                    child: type != 'png' && type != 'jpg' && type != 'jpeg'
                        ? Image(
                            image: type == 'doc' || type == 'docx'
                                ? const AssetImage('assets/images/img-docs.png')
                                : type == 'xls' || type == 'xlsx'
                                    ? const AssetImage(
                                        'assets/images/img-excel.png',
                                      )
                                    : const AssetImage(
                                        'assets/images/img-pdf.png',
                                      ),
                            fit: BoxFit.contain,
                            height: 140,
                          )
                        : Image.file(
                            Get.find<RouteCompletionController>()
                                .docs
                                .value
                                .attachedFile!,
                            width: 200,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
              Positioned(
                top: 2,
                right: 2,
                child: GestureDetector(
                  onTap: () =>
                      Get.find<RouteCompletionController>().removeAttachment(),
                  child: const Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
