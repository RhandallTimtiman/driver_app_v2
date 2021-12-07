// ignore_for_file: prefer_const_constructors
import 'package:driver_app/app/modules/bindings/bindings.dart';
import 'package:driver_app/app/modules/screens/screens.dart';
import 'package:get/get.dart';

class AppRoutes {
  AppRoutes._();

  static final routes = [
    GetPage(
      name: '/',
      page: () => HomeScreen(),
    ),
    GetPage(
      name: '/login',
      page: () => LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: '/about',
      page: () => AboutScreen(),
    ),
  ];
}
