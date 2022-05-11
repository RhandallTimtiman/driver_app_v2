// ignore_for_file: prefer_const_constructors
import 'package:driver_app/app/data/models/models.dart';
import 'package:driver_app/app/modules/bindings/bindings.dart';
import 'package:driver_app/app/modules/bindings/today_trips.binding.dart';
import 'package:driver_app/app/modules/screens/screens.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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
      binding: SettingsBinding(),
      page: () => SettingsScreen(),
    ),
    GetPage(
      name: '/dashboard',
      page: () => DashboardScreen(),
      binding: DashboardMapBinding(),
    ),
    GetPage(
      name: '/blackbox',
      page: () => BlackboxScreen(),
    ),
    GetPage(
      name: '/all-trips',
      page: () => AllTripsScreen(),
      binding: AllTripBinding(),
    ),
    GetPage(
      name: '/today-trips',
      page: () => TodayTrips(),
      binding: TodayTripsBinding(),
    ),
    GetPage(
      name: '/new-trips',
      page: () => NewTrips(),
      binding: NewTripBinding(),
    ),
    GetPage(
      name: '/pending-trips',
      page: () => PendingTrips(),
      binding: PendingTripsBinding(),
    ),
    GetPage(
      name: '/completed-trips',
      page: () => CompletedTrips(),
      binding: CompletedTripsBinding(),
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
      name: '/emergency',
      page: () => EmergencyScreen(),
      binding: EmergencyBinding(),
    ),
    GetPage(
      name: '/select-chassis',
      page: () => ChassisSelectionScreen(),
    ),
    GetPage(
      name: '/disclosure',
      page: () => DisclosureScreen(),
    ),
    GetPage(
      name: '/splash',
      page: () => SplashScreen(),
    ),
    GetPage(
      name: '/trip',
      page: () => TripScreen(),
    )
  ];

  static final List<DrawerItemModel> drawerRoutes = [
    DrawerItemModel(
      routeName: 'Dashboard',
      icon: 'assets/icons/dashboard.png',
      onTap: () {
        Get.offAllNamed('/dashboard');
      },
      width: 23,
    ),
    DrawerItemModel(
      routeName: 'Fleet Selection',
      icon: 'assets/icons/fleet.png',
      onTap: () {
        Get.offAllNamed('/fleet-selection');
      },
      width: 23,
    ),
    DrawerItemModel(
      routeName: "Today's Trips",
      icon: 'assets/icons/alltrips.png',
      onTap: () {
        Get.offAllNamed('/today-trips');
      },
      width: 23,
    ),
    DrawerItemModel(
      routeName: 'New Trips',
      icon: 'assets/icons/alltrips.png',
      onTap: () {
        Get.offAllNamed('/new-trips');
      },
      width: 23,
    ),
    DrawerItemModel(
      routeName: 'Pending Trips',
      icon: 'assets/icons/alltrips.png',
      onTap: () {
        Get.offAllNamed('/pending-trips');
      },
      width: 23,
    ),
    DrawerItemModel(
      routeName: 'Completed Trips',
      icon: 'assets/icons/alltrips.png',
      onTap: () {
        Get.offAllNamed('/completed-trips');
      },
      width: 23,
    ),
    DrawerItemModel(
      routeName: 'All Trips',
      icon: 'assets/icons/alltrips.png',
      onTap: () {
        Get.offAllNamed('/all-trips');
      },
      width: 23,
    ),
    DrawerItemModel(
      routeName: 'Settings',
      icon: 'assets/icons/settings.png',
      onTap: () {
        Get.offAllNamed('/settings');
      },
      width: 23,
    ),
    DrawerItemModel(
      routeName: 'About',
      icon: 'assets/icons/about.png',
      onTap: () {
        Get.offAllNamed('/about');
      },
      width: 23,
    ),
    DrawerItemModel(
      routeName: 'Logout',
      icon: 'assets/icons/logout.png',
      onTap: () {
        GetStorage().remove('user');
        Get.offAllNamed('/login');
      },
      width: 23,
    ),
  ];
}
