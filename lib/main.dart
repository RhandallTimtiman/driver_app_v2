import 'dart:async';

import 'package:driver_app/app/core/constants/app.routes.dart';
import 'package:driver_app/app/core/translation/messages.dart';
import 'package:driver_app/app/modules/bindings/main.binding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
      translations: Messages(),
      initialBinding: MainBinding(),
      initialRoute: manageInitialRoute(),
      getPages: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
    );
  }

  /// Manages Route to redirect in Fleet, Login, Splash and Disclosure
  String manageInitialRoute() {
    var hasAcceptedDisclosure = GetStorage().hasData('disclosure')
        ? GetStorage().read('disclosure')
        : false;

    var hasSession = GetStorage().hasData('user');

    Timer(const Duration(seconds: 5), () {
      debugPrint(hasAcceptedDisclosure.toString());
      if (!hasAcceptedDisclosure) {
        GetStorage().write('disclosure', false);
        Get.toNamed('/disclosure');
      }

      if (hasAcceptedDisclosure) {
        hasSession ? Get.toNamed('/fleet-selection') : Get.toNamed('/login');
      }
    });

    return '/splash';
  }
}
