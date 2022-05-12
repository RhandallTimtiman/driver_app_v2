import 'package:driver_app/app/core/utils/validators.dart';
import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePinModal extends StatefulWidget {
  const ChangePinModal({Key? key}) : super(key: key);

  @override
  State<ChangePinModal> createState() => _ChangePinModalState();
}

class _ChangePinModalState extends State<ChangePinModal> {
  ChangePinController changePinController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      constraints: const BoxConstraints(
        maxWidth: 500,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 30,
                  child: Row(
                    children: const [
                      Text(
                        '',
                        style: TextStyle(
                          color: Color.fromRGBO(3, 127, 170, 1),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: -2,
                  right: -2,
                  child: GestureDetector(
                    onTap: () => changePinController.closeChangePinModal(),
                    child: const Icon(
                      Icons.cancel,
                      size: 35,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(12),
              child: Form(
                key: changePinController.changePinFormKey,
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'change_pin_label'.tr,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                    Obx(
                      () => ChangePinInput(
                        controller: changePinController.oldPinController,
                        obscure: changePinController.obscureOldPin.value,
                        hint: 'old_pin_label'.tr,
                        maxLength: 6,
                        validator: Validators.pinLengthValidator,
                        responseValidator: 'Please input 6 digit pin!',
                        toggle: changePinController.toggleOldPin,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Obx(
                      () => ChangePinInput(
                        controller: changePinController.newPinController,
                        obscure: changePinController.obsecureNewPin.value,
                        hint: 'new_pin_label'.tr,
                        maxLength: 6,
                        validator: Validators.pinLengthValidator,
                        responseValidator: 'Please input 6 digit pin!',
                        toggle: changePinController.toggleNewPin,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Obx(
                      () => ChangePinInput(
                        controller: changePinController.confirmPinController,
                        obscure: changePinController.obsecureConfirmPin.value,
                        hint: 'confirm_pin_label'.tr,
                        maxLength: 6,
                        validator:
                            changePinController.newPinConfirmPinValidator,
                        responseValidator:
                            'New Pin and Confirm Pin does not match!',
                        toggle: changePinController.toggleConfirmPin,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 18),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color.fromRGBO(255, 185, 0, 1),
                        child: MaterialButton(
                          minWidth: MediaQuery.of(context).size.width - 100,
                          onPressed: () => {
                            changePinController.changeNewPin(),
                          },
                          child: Text(
                            "submit_label".tr.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
