import 'package:driver_app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: MainAppBar(
        title: Text(
          'about_label'.tr,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 35.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 175,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: const Center(
                  child: Image(
                    image: AssetImage('assets/icons/applogo.png'),
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
              ),
              Container(
                height: 50,
                margin: const EdgeInsets.only(right: 50),
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(
                    4,
                    127,
                    169,
                    1,
                  ),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(
                      40.0,
                    ),
                    bottomRight: Radius.circular(
                      40.0,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 15.0,
                    left: 50.0,
                  ),
                  child: Text(
                    'about_mission_label'.tr,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 50.0,
                  vertical: 15.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'about_paragraph_1'.tr,
                      style: const TextStyle(
                        color: Colors.black45,
                        wordSpacing: 1.0,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    Text(
                      'about_paragraph_2'.tr,
                      style: const TextStyle(
                        color: Colors.black45,
                        wordSpacing: 1.0,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    Text(
                      'about_paragraph_3'.tr,
                      style: const TextStyle(
                        color: Colors.black45,
                        wordSpacing: 1.0,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
