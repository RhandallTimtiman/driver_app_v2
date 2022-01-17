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
                    ChangePinInput(
                      controller: changePinController.oldPinController,
                      obscure: changePinController.obscureText.value,
                      hint: 'old_pin_label'.tr,
                      maxLength: 6,
                      validator: changePinController.pinLengthValidator,
                      responseValidator: 'Please input 6 digit pin!',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ChangePinInput(
                      controller: changePinController.newPinController,
                      obscure: changePinController.obscureText.value,
                      hint: 'new_pin_label'.tr,
                      maxLength: 6,
                      validator: changePinController.pinLengthValidator,
                      responseValidator: 'Please input 6 digit pin!',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ChangePinInput(
                        controller: changePinController.confirmPinController,
                        obscure: changePinController.obscureText.value,
                        hint: 'confirm_pin_label'.tr,
                        maxLength: 6,
                        validator: changePinController.newPinOldPinValidator,
                        responseValidator:
                            'New Pin and Confirm Pin does not match!'),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 18),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(10.0),
                        color: Theme.of(context).primaryColor,
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
                              fontSize: 20,
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
