import 'package:driver_app/app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlackboxScreen extends StatefulWidget {
  const BlackboxScreen({Key? key}) : super(key: key);

  @override
  _BlackboxScreenState createState() => _BlackboxScreenState();
}

class _BlackboxScreenState extends State<BlackboxScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  void _openMessage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MessageDetailsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: MainAppBar(
        title: Text(
          'blackbox_label'.tr,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        onBackPress: () => Navigator.of(context).pop(),
        showOnlineButton: true,
      ),
      drawer: const MainDrawer(),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey[50],
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              children: [
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 15,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 80,
                      child: Message(
                        isFinal: index == 15 - 1,
                        openMessage: _openMessage,
                        showDot: index % 2 == 1,
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
