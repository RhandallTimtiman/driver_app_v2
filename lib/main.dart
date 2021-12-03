import 'package:driver_app/app/core/constants/app.routes.dart';
import 'package:driver_app/app/core/translation/messages.dart';
import 'package:driver_app/app/modules/bindings/main.binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
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
      locale: const Locale('en', 'US'),
      translations: Messages(),
      initialBinding: MainBinding(),
      initialRoute: "/",
      getPages: AppRoutes.routes,
    );
  }
}
