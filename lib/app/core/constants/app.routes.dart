// ignore_for_file: prefer_const_constructors

import 'package:driver_app/app/modules/screens/home.screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object
  static final routes = [
    GetPage(name: '/', page: () => HomeScreen()),
  ];
}
