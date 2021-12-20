// ignore_for_file: prefer_const_constructors
import 'package:driver_app/app/data/models/models.dart';
import 'package:driver_app/app/modules/bindings/bindings.dart';
import 'package:driver_app/app/modules/screens/all_trips.screen.dart';
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
    GetPage(
      name: '/settings',
      page: () => SettingsScreen(),
    ),
    GetPage(
      name: '/dashboard',
      binding: TripBinding(),
      page: () => DashboardScreen(),
    ),
    GetPage(
      name: '/blackbox',
      page: () => BlackboxScreen(),
    ),
    GetPage(
      name: '/alltrips',
      page: () => AllTrips('all_trip'),
    ),
    GetPage(
      name: '/todaystrips',
      page: () => AllTrips('today_trip'),
    ),
    GetPage(
      name: '/newtrips',
      page: () => AllTrips('new_trip'),
    ),
    GetPage(
      name: '/pendingtrips',
      page: () => AllTrips('pending_trip'),
    ),
    GetPage(
      name: '/completedtrips',
      page: () => AllTrips('completed_trip'),
    ),
  ];

  static final List<DrawerItemModel> drawerRoutes = [
    DrawerItemModel(
      routeName: 'Dashboard',
      icon: 'assets/icons/dashboard.png',
      onTap: () {
        Get.toNamed('/dashboard');
      },
      width: 23,
    ),
    DrawerItemModel(
      routeName: 'Settings',
      icon: 'assets/icons/settings.png',
      onTap: () {
        Get.toNamed('/settings');
      },
      width: 23,
    ),
    DrawerItemModel(
      routeName: 'About',
      icon: 'assets/icons/about.png',
      onTap: () {
        Get.toNamed('/about');
      },
      width: 23,
    ),
    DrawerItemModel(
      routeName: "Today's Trips",
      icon: 'assets/icons/alltrips.png',
      onTap: () {
        Get.toNamed('/todaystrips');
      },
      width: 23,
    ),
    DrawerItemModel(
      routeName: 'New Trips',
      icon: 'assets/icons/alltrips.png',
      onTap: () {
        Get.toNamed('/newtrips');
      },
      width: 23,
    ),
    DrawerItemModel(
      routeName: 'Completed Trips',
      icon: 'assets/icons/alltrips.png',
      onTap: () {
        Get.toNamed('/completedtrips');
      },
      width: 23,
    ),
    DrawerItemModel(
      routeName: 'Pending Trips',
      icon: 'assets/icons/alltrips.png',
      onTap: () {
        Get.toNamed('/pendingtrips');
      },
      width: 23,
    ),
    DrawerItemModel(
      routeName: 'All Trips',
      icon: 'assets/icons/alltrips.png',
      onTap: () {
        Get.toNamed('/alltrips');
      },
      width: 23,
    ),
  ];
}
