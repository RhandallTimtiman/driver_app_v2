import 'package:driver_app/app/data/controllers/controllers.dart';
import 'package:driver_app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  double _width = 0.0;
  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  void _closeAnimatedCircle() {
    setState(() {
      _width = 10;
    });
  }

  void _openAnimatedCircle() {
    setState(() {
      _width = 420.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: MainAppBar(
        title: Text(
          'dashboard_label'.tr,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        onMenuPress: () => openDrawer(),
        showOnlineButton: true,
      ),
      drawer: const MainDrawer(),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            const DashboardTripButton(),
            GetBuilder<StatusController>(
              builder: (_) => Positioned(
                top: 55,
                left: 0,
                child: AnimatedOpacity(
                  opacity: _.onlineStatus.value.isDisplayed ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    width: size.width,
                    height: 45,
                    color: _.onlineStatus.value.isOnline
                        ? Colors.green[400]
                        : Colors.red[400],
                    child: _.onlineStatus.value.child,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 10,
              bottom: 110,
              child: RawMaterialButton(
                onPressed: () => {},
                elevation: 3,
                fillColor: Colors.white,
                shape: const CircleBorder(),
                child: const Image(
                  image: AssetImage('assets/icons/locator.png'),
                  width: 22,
                ),
                padding: const EdgeInsets.all(
                  20,
                ),
              ),
            ),
            Positioned(
              right: -135,
              bottom: -155,
              child: AnimatedSize(
                duration: const Duration(milliseconds: 100),
                curve: Curves.ease,
                child: Container(
                  width: _width,
                  height: _width,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(
                      0,
                      129,
                      174,
                      1,
                    ),
                  ),
                ),
              ),
            ),
            FancyButton(
              openAnimatedCircle: _openAnimatedCircle,
              closeAnimatedCircle: _closeAnimatedCircle,
              bottom: 35.0,
            ),
          ],
        ),
      ),
    );
  }
}
