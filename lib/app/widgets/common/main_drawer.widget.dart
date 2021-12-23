import 'package:cached_network_image/cached_network_image.dart';
import 'package:driver_app/app/core/constants/app.routes.dart';
import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/data/models/models.dart';
import 'package:driver_app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:get/get.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width / 2,
      height: size.height,
      child: Drawer(
        child: Container(
          padding: const EdgeInsets.all(0),
          decoration: const BoxDecoration(
            color: Color.fromRGBO(4, 127, 169, 1),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 250,
                width: size.width,
                child: Stack(
                  children: [
                    Positioned(
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 10),
                        height: 150,
                        width: size.width,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: SafeArea(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Image(
                                      image: AssetImage(
                                        'assets/images/xlog-driver-blue.png',
                                      ),
                                      height: 50,
                                      fit: BoxFit.contain,
                                    ),
                                    InkWell(
                                      onTap: () => Get.back(),
                                      child: const Image(
                                        image: AssetImage(
                                          'assets/icons/sidemenu.png',
                                        ),
                                        width: 25,
                                        height: 25,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 110,
                      child: SizedBox(
                        width: size.width / 2,
                        child: const Center(
                          child: ProfileArc(
                            diameter: 115,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 10),
                        height: 100,
                        width: size.width,
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(4, 127, 169, 1),
                          border: Border(
                            top: BorderSide(
                              color: Color.fromRGBO(255, 185, 0, 1),
                              width: 3.0,
                            ),
                            bottom: BorderSide(
                              color: Colors.white38,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    GetBuilder<DriverController>(
                      init: DriverController(),
                      builder: (controller) {
                        return Positioned(
                          top: 112,
                          child: SizedBox(
                            width: size.width / 2,
                            child: Center(
                              child: InkWell(
                                onTap: () => {
                                  Get.toNamed('/profile'),
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 5,
                                        color: Colors.black54,
                                        spreadRadius: 1,
                                        offset: Offset(0, 3),
                                      )
                                    ],
                                  ),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 55,
                                    child: Hero(
                                      tag: 'profile-driver-image',
                                      child: CircleAvatar(
                                        backgroundImage:
                                            CachedNetworkImageProvider(
                                          controller.driver.value.driverImage,
                                        ),
                                        radius: 53,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 10),
                  itemCount: AppRoutes.drawerRoutes.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    DrawerItemModel item = AppRoutes.drawerRoutes[index];
                    return DrawerItem(
                      icon: item.icon,
                      name: item.routeName,
                      onTap: item.onTap,
                      width: item.width,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileArc extends StatelessWidget {
  final double diameter;

  const ProfileArc({
    Key? key,
    this.diameter = 200,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyPainter(),
      size: Size(diameter, diameter),
    );
  }
}

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = const Color.fromRGBO(255, 185, 0, 1);
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.height / 2, size.width / 2),
        height: size.height,
        width: size.width,
      ),
      math.pi,
      math.pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
