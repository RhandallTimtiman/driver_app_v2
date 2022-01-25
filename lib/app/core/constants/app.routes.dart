// ignore_for_file: prefer_const_constructors
import 'package:driver_app/app/data/models/models.dart';
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
      name: '/all-trips',
      page: () => AllTripsScreen(),
    ),
    GetPage(
      name: '/today-trips',
      page: () => TodayTrips(),
    ),
    GetPage(
      name: '/new-trips',
      page: () => NewTrips(),
    ),
    GetPage(
      name: '/pending-trips',
      page: () => PendingTrips(),
    ),
    GetPage(
      name: '/completed-trips',
      page: () => CompletedTrips(),
    ),
    GetPage(
      name: '/fleet-selection',
      page: () => FleetSelectionScreen(),
      binding: VehicleBinding(),
    ),
    GetPage(
      name: '/profile',
      page: () => ProfileScreen(),
    ),
    GetPage(
      name: '/select-chassis',
      page: () => ChassisSelectionScreen(),
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
      routeName: 'Fleet Selection',
      icon: 'assets/icons/fleet.png',
      onTap: () {
        Get.toNamed('/fleet-selection');
      },
      width: 23,
    ),
    DrawerItemModel(
      routeName: "Today's Trips",
      icon: 'assets/icons/alltrips.png',
      onTap: () {
        Get.toNamed('/today-trips');
      },
      width: 23,
    ),
    DrawerItemModel(
      routeName: 'New Trips',
      icon: 'assets/icons/alltrips.png',
      onTap: () {
        Get.toNamed('/new-trips');
      },
      width: 23,
    ),
    DrawerItemModel(
      routeName: 'Pending Trips',
      icon: 'assets/icons/alltrips.png',
      onTap: () {
        Get.toNamed('/pending-trips');
      },
      width: 23,
    ),
    DrawerItemModel(
      routeName: 'Completed Trips',
      icon: 'assets/icons/alltrips.png',
      onTap: () {
        Get.toNamed('/completed-trips');
      },
      width: 23,
    ),
    DrawerItemModel(
      routeName: 'All Trips',
      icon: 'assets/icons/alltrips.png',
      onTap: () {
        Get.toNamed('/all-trips');
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
      routeName: 'Logout',
      icon: 'assets/icons/logout.png',
      onTap: () {
        Get.offAllNamed('/login');
      },
      width: 23,
    ),
  ];
}
