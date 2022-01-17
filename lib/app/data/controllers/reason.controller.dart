import 'package:driver_app/app/data/interfaces/interfaces.dart';
import 'package:driver_app/app/data/models/models.dart';
import 'package:driver_app/app/data/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReasonController extends GetxController {
  final reasonList = <ReportIssue>[].obs;

  final reason = ReportIssue().obs;

  final IEmergency _emergencyService = EmergencyService();

  /// Get Reason List
  void getReasonList() async {
    _emergencyService.getReportIssueType().then(
      (value) {
        setReasonList(value);
      },
    ).catchError(
      (error) {
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
      },
    );
  }

  @override
  void onInit() {
    getReasonList();
    super.onInit();
  }

  /// Set Reason List
  void setReasonList(value) {
    reasonList.value = value;
    update();
  }

  void setReason(value) {
    reason.value = value;
    update();
  }
}
