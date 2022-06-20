import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/data/models/models.dart';
import 'package:driver_app/app/modules/bindings/bindings.dart';
import 'package:driver_app/app/modules/screens/screens.dart';
import 'package:driver_app/app/widgets/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AppRoutes {
  AppRoutes._();

  static final routes = [
    GetPage(
      name: '/',
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: '/login',
      page: () => const LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: '/about',
      page: () => const AboutScreen(),
    ),
    GetPage(
      name: '/settings',
      binding: SettingsBinding(),
      page: () => const SettingsScreen(),
    ),
    GetPage(
      name: '/dashboard',
      page: () => const DashboardScreen(),
      binding: DashboardMapBinding(),
    ),
    GetPage(
      name: '/blackbox',
      page: () => const BlackboxScreen(),
    ),
    GetPage(
      name: '/all-trips',
      page: () => const AllTripsScreen(),
      binding: AllTripBinding(),
    ),
    GetPage(
      name: '/today-trips',
      page: () => const TodayTrips(),
      binding: TodayTripsBinding(),
    ),
    GetPage(
      name: '/new-trips',
      page: () => const NewTrips(),
      binding: NewTripBinding(),
    ),
    GetPage(
      name: '/pending-trips',
      page: () => const PendingTrips(),
      binding: PendingTripsBinding(),
    ),
    GetPage(
      name: '/completed-trips',
      page: () => const CompletedTrips(),
      binding: CompletedTripsBinding(),
    ),
    GetPage(
      name: '/fleet-selection',
      page: () => const FleetSelectionScreen(),
      binding: VehicleBinding(),
    ),
    GetPage(
      name: '/profile',
      page: () => const ProfileScreen(),
    ),
    GetPage(
      name: '/emergency',
      page: () => const EmergencyScreen(),
      binding: EmergencyBinding(),
    ),
    GetPage(
      name: '/select-chassis',
      page: () => const ChassisSelectionScreen(),
    ),
    GetPage(
      name: '/disclosure',
      page: () => const DisclosureScreen(),
    ),
    GetPage(
      name: '/splash',
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: '/trip',
      page: () => const TripScreen(),
      binding: CurrentTripBinding(),
    ),
    GetPage(
      name: '/trip-summary',
      page: () => const TripSummary(),
    ),
    GetPage(
      name: '/notification',
      page: () => const NotificationListScreen(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: '/route-simulation',
      page: () => const RouteSimulationScreen(),
      binding: RouteSimulationBinding(),
    ),
    GetPage(
      name: '/qr-reader',
      page: () => const QrReader(),
    ),
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
        Get.find<OngoingTripController>().setHasOnGoingTrip(false);
        Get.find<DriverController>().clearDriver();
        Get.find<LocationController>().disposeListener();
        GetStorage().remove('user');
        Get.offAllNamed('/login');
      },
      width: 23,
    ),
  ];
}
