import 'dart:io';
import 'dart:typed_data';

import 'package:driver_app/app/data/models/models.dart';
import 'package:get/state_manager.dart';

class DocumentsController extends GetxController {
  final docs = DocumentStates().obs;
  final docGroup = DocumentGroupsState().obs;

  setDocs(DocumentStates documents) {
    docs.update((_) {
      _?.attachedFile = documents.attachedFile;
      _?.attachedFileName = documents.attachedFileName;
      _?.attachedFileType = documents.attachedFileType;
      _?.category = documents.category;
      _?.signatureData = documents.signatureData;
      _?.imageList = documents.imageList;
    });
  }

  addImage(File img) {
    docs.update((_) {
      _?.imageList?.add(img);
    });
  }

  removeImage(File img) {
    docs.update((_) {
      _?.imageList?.remove(img);
    });
  }

  addAttachmentFile(File file, String name, String type) {
    docs.update((_) {
      _?.attachedFile = file;
      _?.attachedFileName = name;
      _?.attachedFileType = type;
    });
  }

  removeAttachment() {
    docs.update((_) {
      _?.attachedFile = null;
      _?.attachedFileName = null;
      _?.attachedFileType = null;
    });
  }

  addSignaturedata(Uint8List signatureData) {
    docs.update((_) {
      _?.signatureData = signatureData;
    });
  }

  clearSignature() {
    docs.update((_) {
      _?.signatureData = null;
    });
  }

  setCategory(DocumentCategory category) {
    docs.update((_) {
      _?.category = category;
    });
  }

  addDocumentGroup(DocumentStates docs) {
    docGroup.update((_) {
      _?.documentList.add(docs);
    });
  }

  updateDocumentGroup(DocumentStates docs, int index) {
    docGroup.update((_) {
      _?.documentList[index] = docs;
    });
  }

  clearDocuments() {
    docs.update((_) {
      _?.attachedFile = null;
      _?.attachedFileName = null;
      _?.attachedFileType = null;
      _?.category = null;
      _?.signatureData = null;
      _?.imageList = [];
    });
  }

  clearDocumentGroups() {
    docGroup.update((_) {
      _?.documentList = [];
    });
  }
}
