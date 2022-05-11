import 'dart:io';

import 'dart:typed_data';

import 'package:driver_app/app/data/models/models.dart';

class DocumentGroupsState {
  List<DocumentStates> documentList = [];
}

class DocumentStates {
  DocumentCategory? category;
  Uint8List? signatureData;
  File? attachedFile;
  String? attachedFileName;
  String? attachedFileType;
  List<File>? imageList = [];
  DocumentStates({
    this.category,
    this.signatureData,
    this.attachedFile,
    this.attachedFileName,
    this.attachedFileType,
  });
}
