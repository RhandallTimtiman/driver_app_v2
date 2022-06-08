import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/data/interfaces/interfaces.dart';
import 'package:driver_app/app/data/models/models.dart';
import 'package:driver_app/app/data/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RejectTripController extends GetxController {
  final reasonList = <ReasonRejection>[].obs;

  final reason = ReasonRejection().obs;

  final ITrip _tripService = TripService();

  RxBool loading = false.obs;

  final TextEditingController remarksController = TextEditingController();

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

  /// Get Reason List
  void getReasonList() async {
    _tripService.getListOfReasonOfRejection().then(
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
          icon: const Icon(Icons.warning),
          duration: const Duration(
            seconds: 4,
          ),
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(15),
        );
      },
    );
  }

  handleRejectTrip(Trip trip) {
    setLoading(true);
    if (reason.value.driverReasonofRejectionId != '') {
      Get.back();
      _tripService
          .rejectSelectedTrip(
        acquiredTruckingServiceId: trip.acquiredTruckingServiceId,
        remarks: remarksController.text,
        reasonOfRejectionId: reason.value.driverReasonofRejectionId,
      )
          .then(
        (value) {
          Get.back();
          if (value['isSuccessful']) {
            setLoading(false);
            toggleOnline();
            Get.back();
          } else {
            Get.back();
            Get.snackbar(
              'error_snackbar_title'.tr,
              ['message'].toString(),
              backgroundColor: Colors.red[400],
              colorText: Colors.white,
              duration: const Duration(
                seconds: 4,
              ),
              snackPosition: SnackPosition.BOTTOM,
              margin: const EdgeInsets.all(15),
            );
          }
        },
      ).catchError(
        (onError) {
          Get.back();
          setLoading(false);
          Get.snackbar(
            'error_snackbar_title'.tr,
            onError.toString(),
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
      setLoading(false);
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

  toggleOnline() {
    Get.back();
    String message =
        'Trip management is locked. Please contact your dispatcher';

    Get.find<StatusController>().toggleOnlineButtonFromReject(
      callback: () {
        bool test = Get.isRegistered<NewTripsController>();
        if (test) {
          Get.find<NewTripsController>().getTripList();
        }
      },
      messageStr: message,
    );
  }
}
