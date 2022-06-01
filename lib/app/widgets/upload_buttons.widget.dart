import 'dart:developer';
import 'dart:io';

import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/widgets/widgets.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UploadButtons extends StatelessWidget {
  final Function addSignature;
  final picker = ImagePicker();

  UploadButtons({
    Key? key,
    required this.addSignature,
  }) : super(key: key);

  returnImage(File file) {
    Get.find<RouteCompletionController>().addImage(File(file.path));
  }

  Future captureImage(context) async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 20);
    inspect(pickedFile);
    if (pickedFile != null) {
      await Get.dialog(
        LocationImage(
          image: File(pickedFile.path),
          returnImage: returnImage,
        ),
      );
    }
  }

  Future fileSelect() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xls', 'xlsx', 'pdf', 'doc', 'docx', 'png', 'jpg'],
    );

    PlatformFile file = result!.files.first;
    Get.find<RouteCompletionController>().addAttachmentFile(
        File(result.files.single.path!), file.name, file.extension!);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ButtonTheme(
            padding: const EdgeInsets.symmetric(
              vertical: 7.0,
              horizontal: 7.0,
            ),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            minWidth: 0,
            height: 0,
            child: MaterialButton(
              child: const Image(
                image: AssetImage('assets/icons/attachment.png'),
                width: 20,
                fit: BoxFit.contain,
              ),
              onPressed: () => fileSelect(),
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  color: Colors.black45,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ButtonTheme(
            padding: const EdgeInsets.symmetric(
              vertical: 7.0,
              horizontal: 7.0,
            ),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            minWidth: 0,
            height: 0,
            child: MaterialButton(
              child: const Image(
                image: AssetImage('assets/icons/camera.png'),
                width: 20,
                fit: BoxFit.contain,
              ),
              onPressed: () => captureImage(context),
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  color: Colors.black45,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ButtonTheme(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 20.0,
            ),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            minWidth: 0,
            height: 0,
            child: MaterialButton(
              child: const Text("Signature"),
              onPressed: () => addSignature(),
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  color: Colors.black45,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
