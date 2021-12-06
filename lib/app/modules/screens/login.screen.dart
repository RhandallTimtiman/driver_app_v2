import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  AuthController authController = Get.find();

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    super.initState();

    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromRGBO(42, 85, 118, 1),
          image: DecorationImage(
            image: AssetImage(
              'assets/images/login.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            child: Form(
              key: authController.authFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 50, bottom: 50),
                    child: Center(
                      child: FadeTransition(
                        opacity: _animation,
                        child: const Image(
                          width: 250,
                          image: AssetImage(
                            'assets/images/driver-app-logo.png',
                          ),
                        ),
                      ),
                    ),
                  ),
                  FadeTransition(
                    opacity: _animation,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(
                          3,
                          127,
                          169,
                          1,
                        ),
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromRGBO(3, 127, 169, 0.2),
                            Colors.transparent
                          ],
                        ),
                        borderRadius: BorderRadius.circular(
                          20.0,
                        ),
                      ),
                      padding: const EdgeInsets.only(
                        top: 30,
                        left: 10,
                        right: 10,
                      ),
                      constraints: const BoxConstraints(
                        maxWidth: 500,
                      ),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      child: Column(
                        children: [
                          AuthInput(
                            prefixIcon: 'assets/icons/user-name.png',
                            controller: authController.userNameController,
                            hint: 'username_label'.tr,
                            isPassword: false,
                            obscure: false,
                            toggle: authController.toggle,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Obx(
                            () => AuthInput(
                              prefixIcon: 'assets/icons/change-pin.png',
                              controller: authController.pinController,
                              hint: 'pin_label'.tr,
                              isPassword: true,
                              obscure: authController.obscureText.value,
                              toggle: authController.toggle,
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              left: 20,
                              right: 20,
                            ),
                            child: Material(
                              elevation: 5.0,
                              borderRadius: BorderRadius.circular(10.0),
                              color: const Color.fromRGBO(244, 162, 64, 1),
                              child: MaterialButton(
                                minWidth: size.width,
                                onPressed: () => authController.signIn(),
                                child: Text(
                                  "login_label".tr,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 30,
                            ),
                            child: InkWell(
                              onTap: () {},
                              child: Text(
                                'forgot_pin_label'.tr,
                                textAlign: TextAlign.end,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
