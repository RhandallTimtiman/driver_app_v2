import 'package:driver_app/app/data/controllers/theme.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text('hello'.tr),
          MaterialButton(
            child: const Text('US'),
            onPressed: () {
              Get.updateLocale(
                const Locale('us', 'US'),
              );
            },
          ),
          MaterialButton(
            child: const Text('DE'),
            onPressed: () {
              Get.updateLocale(
                const Locale('de', 'DE'),
              );
            },
          ),
          MaterialButton(
            child: Obx(
              () => Text(
                  themeController.isDarkMode.value ? 'Is Dark' : 'Is Light'),
            ),
            onPressed: () {
              themeController.changeTheme();
            },
          )
        ],
      ),
    );
  }
}
