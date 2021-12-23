import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GetX<DriverController>(
                  init: DriverController(),
                  builder: (_) {
                    return Column(
                      children: [
                        ProfileImage(
                          tag: 'profile-driver-image',
                          imgUrl: _.driver.value.driverImage,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(
                            top: 30.0,
                            left: 40.0,
                            right: 40.0,
                          ),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              FieldLabel(
                                fieldName: 'profile_name_label'.tr,
                                fieldVaue:
                                    '${_.driver.value.firstName} ${_.driver.value.lastName}',
                              ),
                              FieldLabel(
                                fieldName: 'profile_age_label'.tr,
                                fieldVaue: _.driver.value.age.toString(),
                              ),
                              FieldLabel(
                                fieldName: 'profile_status_label'.tr,
                                fieldVaue: _.driver.value.status == 0
                                    ? 'Active'
                                    : 'Inactive',
                              ),
                              FieldLabel(
                                fieldName: 'profile_license_number_label'.tr,
                                fieldVaue:
                                    _.driver.value.licenseNumber ?? 'N/A',
                              ),
                              FieldLabel(
                                fieldName: 'profile_license_type_label'.tr,
                                fieldVaue: _.driver.value.licenseName ?? 'N/A',
                              ),
                              FieldLabel(
                                fieldName: 'profile_mobile_number_label'.tr,
                                fieldVaue:
                                    '${_.driver.value.mobileNumberPrefix}${_.driver.value.mobileNumber}',
                              ),
                              FieldLabel(
                                fieldName: 'profile_email_label'.tr,
                                fieldVaue: _.driver.value.emailAddress ?? 'N/A',
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Image(
                    image: AssetImage('assets/images/powered-by.png'),
                    fit: BoxFit.cover,
                    height: 60,
                    width: 100,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
