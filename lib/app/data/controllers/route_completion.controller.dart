import 'dart:io';
import 'dart:typed_data';

import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/data/interfaces/interfaces.dart';
import 'package:driver_app/app/data/models/models.dart';
import 'package:driver_app/app/data/services/services.dart';
import 'package:driver_app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:signature/signature.dart';

class RouteCompletionController extends GetxController {
  TextEditingController receivedByController = TextEditingController();

  TextEditingController contactNumberController = TextEditingController();

  var maskFormatter = MaskTextInputFormatter(
    mask: '####-####-####-####-####',
    filter: {
      "#": RegExp(r'[0-9]'),
    },
  );

  final ICurrentTrip currentTripService = CurrentTripService();

  List<CallingCode> callingCodeList = <CallingCode>[].obs;

  String callingCode = '';

  RxBool loading = false.obs;

  final Trip currentTrip =
      Get.find<CurrentTripController>().currentTrip.value.trip;

  // List of containers
  List<TextEditingController> containerControllers = List.generate(
      Get.find<CurrentTripController>()
          .currentTrip
          .value
          .trip
          .containerList
          .length, (i) {
    TextEditingController controller = TextEditingController();
    controller.text = "";
    return controller;
  });

  // List of Tracking Device
  List<TextEditingController> trackingDeviceControllers = List.generate(
      Get.find<CurrentTripController>()
          .currentTrip
          .value
          .trip
          .containerList
          .length, (i) {
    TextEditingController controller = TextEditingController();
    controller.text = "";
    return controller;
  });

  List<dynamic> containerHasScanned = List.generate(
      Get.find<CurrentTripController>()
          .currentTrip
          .value
          .trip
          .containerList
          .length, (i) {
    return {"hasScanned": false, "trackingDeviceId": ""};
  });

  List<dynamic> containerInformation = List.generate(
      Get.find<CurrentTripController>()
          .currentTrip
          .value
          .trip
          .containerList
          .length, (i) {
    return {
      "containerNumber": Get.find<CurrentTripController>()
          .currentTrip
          .value
          .trip
          .containerList[i]
          .containerNumber,
      "hasContainerNumber": Get.find<CurrentTripController>()
                  .currentTrip
                  .value
                  .trip
                  .containerList[i]
                  .containerNumber !=
              null
          ? true
          : false,
      "hasTaken": false
    };
  });

  // ==== Document Setup ==== //
  final docs = DocumentStates().obs;

  final docGroup = DocumentGroupsState().obs;

  List<DocumentCategory> documentCategories = <DocumentCategory>[].obs;

  final SignatureController signatureController = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  // ==== End of Document Setup ===//

  getListCallingCode() {
    setLoading();
    currentTripService.getCallingCodeList().then(
      (value) {
        setLoading();
        setCallingCodeList(value);
      },
    ).catchError((error) {
      setLoading();
      Get.snackbar(
        'error_snackbar_title'.tr,
        error.toString(),
        backgroundColor: Colors.red[400],
        colorText: Colors.white,
        duration: const Duration(
          seconds: 4,
        ),
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(15),
      );
    });
  }

  void setLoading() {
    loading.toggle();
    update();
  }

  void setCallingCodeList(List<CallingCode> list) {
    callingCodeList = list
        .where(
          (CallingCode element) => element.callingCode != 'NONE',
        )
        .toList();
    update();
  }

  setCallingCode(String code) {
    callingCode = code;
    update();
  }

  setup() {
    getListCallingCode();
    setCallingCode(
      Get.find<DriverController>().driver.value.mobileNumberPrefix.toString(),
    );

    update();
  }

  updateContainerControllers(i, availableContainer, indexC) {
    containerControllers[i].text =
        availableContainer[indexC]["containerNumber"];
    containerInformation[indexC]["hasTaken"] = true;
    containerHasScanned[i]["hasScanned"] = false;
  }

  updateContainerHasScanned(i) {
    containerHasScanned[i]["hasScanned"] = false;
    containerHasScanned[i]["trackingDeviceId"] = "";
  }

  void addDocument(value) {
    Get.bottomSheet(
      AddDocument(index: value),
      isScrollControlled: true,
    );
  }

  setDocs(DocumentStates documents) {
    docs.value = documents;
    update();
  }

  addImage(File img) {
    docs.value.imageList?.add(img);
    update();
  }

  removeImage(File img) {
    docs.value.imageList?.remove(img);
    update();
  }

  addAttachmentFile(File file, String name, String type) {
    docs.value.attachedFile = file;
    docs.value.attachedFileName = name;
    docs.value.attachedFileType = type;
    update();
  }

  removeAttachment() {
    docs.value.attachedFile = null;
    docs.value.attachedFileName = null;
    docs.value.attachedFileType = null;
    update();
  }

  addSignaturedata(Uint8List signatureData) {
    docs.value.signatureData = signatureData;
    update();
  }

  clearSignature() {
    docs.value.signatureData = null;
    signatureController.clear();
    update();
  }

  setCategory(DocumentCategory category) {
    docs.value.category = category;
    update();
  }

  addDocumentGroup(DocumentStates docs) {
    docGroup.value.documentList.add(docs);
    update();
  }

  updateDocumentGroup(DocumentStates docs, int index) {
    docGroup.value.documentList[index] = docs;
    update();
  }

  clearDocuments() {
    docs.value.attachedFile = null;
    docs.value.attachedFileName = null;
    docs.value.attachedFileType = null;
    docs.value.category = null;
    docs.value.signatureData = null;
    docs.value.imageList = [];
    signatureController.clear();
    update();
  }

  clearDocumentGroups() {
    docGroup.value.documentList = [];
    update();
  }

  getDocumentCategories() {
    currentTripService.getDocumentCategories().then((value) {
      setDocumentCategories(value);
    }).catchError((error) {
      Get.snackbar(
        'error_snackbar_title'.tr,
        error.toString(),
        backgroundColor: Colors.red[400],
        colorText: Colors.white,
        duration: const Duration(
          seconds: 4,
        ),
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(15),
      );
    });
  }

  setDocumentCategories(List<DocumentCategory> categories) {
    documentCategories = categories;
    update();
  }

  addSignature() {
    Get.bottomSheet(
      const AddSignature(),
      isScrollControlled: true,
    );
  }

  saveSignature() async {
    if (signatureController.isNotEmpty) {
      Get.back();

      var data = await signatureController.toPngBytes();
      addSignaturedata(data!);
    }
  }

  addTripDocuments(index) {
    if (index == null) {
      DocumentStates doc = DocumentStates(
        attachedFile: docs.value.attachedFile,
        attachedFileName: docs.value.attachedFileName,
        attachedFileType: docs.value.attachedFileType,
        signatureData: docs.value.signatureData,
        category: docs.value.category,
      );
      doc.imageList = docs.value.imageList;
      addDocumentGroup(doc);
      clearDocuments();
    } else {
      DocumentStates doc = DocumentStates(
        attachedFile: docs.value.attachedFile,
        attachedFileName: docs.value.attachedFileName,
        attachedFileType: docs.value.attachedFileType,
        signatureData: docs.value.signatureData,
        category: DocumentCategory(
          description: docs.value.category!.description,
          documentCategoryId: docs.value.category!.documentCategoryId,
        ),
      );
      doc.imageList = docs.value.imageList;
      updateDocumentGroup(doc, index);
      clearDocuments();
    }
    Get.back();
  }

  submitDocuments() {
    String receivedBy = receivedByController.text;
    String contactNumber = maskFormatter.getUnmaskedText();

    if (receivedBy.isEmpty) {
      showError('Please enter received by!');
    } else if (contactNumber.isEmpty) {
      showError('Please enter Contact number!');
    } else if (callingCode.isEmpty) {
      showError('Please Select Calling Code!');
    } else {
      Get.dialog(
        const ModalLoader(message: 'Uploading documents...'),
      );
    }

    List<Map> containerList = [];

    for (var i = 0; i <= containerControllers.length - 1; i++) {
      containerList.add({
        "ContainerNo": containerControllers[i].text,
        "trackingDeviceId": trackingDeviceControllers[i].text
      });
    }

    List<DocumentModel> documentLists = <DocumentModel>[];
  }

  showError(error) {
    Get.snackbar(
      'error_snackbar_title'.tr,
      error,
      backgroundColor: Colors.red[400],
      colorText: Colors.white,
      duration: const Duration(
        seconds: 4,
      ),
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(15),
    );
  }
}
