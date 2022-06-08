import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/data/interfaces/interfaces.dart';
import 'package:driver_app/app/data/models/models.dart';
import 'package:driver_app/app/data/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmergencyController extends GetxController {
  final reasonList = <ReportIssue>[].obs;

  final reason = ReportIssue().obs;

  final IEmergency _emergencyService = EmergencyService();

  RxBool loading = false.obs;

  final TextEditingController remarksController = TextEditingController();

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

  void reportIssue({
    int acquiredTruckingServiceId = 0,
    required bool isSos,
  }) {
    bool test = Get.isRegistered<CurrentTripController>();
    if (isSos || reason.value.reportIssueTypeId != '') {
      setLoading(true);
      _emergencyService
          .reportIssue(
        reportIssueTypeId: isSos ? null : reason.value.reportIssueTypeId,
        acquiredTruckingServiceId: test
            ? Get.find<CurrentTripController>()
                .currentTrip
                .value
                .trip
                .acquiredTruckingServiceId
            : acquiredTruckingServiceId,
        remarks: isSos ? null : remarksController.text,
        driverId: Get.find<DriverController>().driver.value.driverId.toString(),
      )
          .then(
        (value) {
          setLoading(false);
          Get.back();
          Get.snackbar(
            'success_snackbar_title'.tr,
            value.message.toString(),
            colorText: Colors.white,
            backgroundColor: Colors.green[500],
            duration: const Duration(
              seconds: 2,
            ),
            margin: const EdgeInsets.all(15),
            snackPosition: SnackPosition.BOTTOM,
          );
        },
      ).catchError(
        (error) {
          setLoading(false);
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
    } else {
      Get.snackbar(
        'error_snackbar_title'.tr,
        'Please select a reason to report.',
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

  void setLoading(value) {
    loading.value = value;
    update();
  }
}
