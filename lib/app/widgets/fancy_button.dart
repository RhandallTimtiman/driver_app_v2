import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'circular_button.dart';

class FancyButton extends StatefulWidget {
  final double bottom;
  final Function? openAnimatedCircle;
  final Function? closeAnimatedCircle;

  const FancyButton({
    Key? key,
    this.openAnimatedCircle,
    this.closeAnimatedCircle,
    this.bottom = 0.0,
  }) : super(key: key);
  @override
  _FancyButtonState createState() => _FancyButtonState();
}

class _FancyButtonState extends State<FancyButton>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation degOneTranslationAnimation,
      degTwoTranslationAnimation,
      degThreeTranslationAnimation,
      degForthTranslationAnimation;
  late Animation rotationAnimation;

  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));

    degOneTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.0, end: 1.2),
        weight: 75.0,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 1.2, end: 1.0),
        weight: 25.0,
      ),
    ]).animate(animationController);

    degTwoTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
        tween: Tween<double>(
          begin: 0.0,
          end: 1.4,
        ),
        weight: 55.0,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(
          begin: 1.4,
          end: 1.0,
        ),
        weight: 45.0,
      ),
    ]).animate(animationController);

    degThreeTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
        tween: Tween<double>(
          begin: 0.0,
          end: 1.75,
        ),
        weight: 35.0,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(
          begin: 1.75,
          end: 1.0,
        ),
        weight: 65.0,
      ),
    ]).animate(animationController);

    degForthTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
        tween: Tween<double>(
          begin: 0.0,
          end: 2,
        ),
        weight: 15.0,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(
          begin: 2,
          end: 1.0,
        ),
        weight: 85.0,
      ),
    ]).animate(animationController);

    rotationAnimation = Tween<double>(
      begin: 180.0,
      end: 0.0,
    ).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));
    super.initState();
    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        right: 23,
        bottom: widget.bottom,
        child: Stack(
          alignment: Alignment.bottomRight,
          children: <Widget>[
            IgnorePointer(
              child: Container(
                color: Colors.black.withOpacity(0.0),
                height: 200.0,
                width: 200.0,
              ),
            ),
            Transform.translate(
              offset: Offset.fromDirection(getRadiansFromDegree(285),
                  degOneTranslationAnimation.value * 130),
              child: Transform(
                transform: Matrix4.rotationZ(
                    getRadiansFromDegree(rotationAnimation.value))
                  ..scale(degOneTranslationAnimation.value),
                alignment: Alignment.center,
                child: CircularButton(
                  color: const Color.fromRGBO(0, 129, 174, 1),
                  width: 60,
                  height: 60,
                  image: 'assets/icons/sos.png',
                  title: 'emergency_label'.tr,
                  onClick: () {
                    widget.closeAnimatedCircle!();
                    animationController.reverse();
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => ReportScreen(
                    //       trip: widget.trip,
                    //     ),
                    //   ),
                    // );
                  },
                ),
              ),
            ),
            Transform.translate(
              offset: Offset.fromDirection(getRadiansFromDegree(245),
                  degTwoTranslationAnimation.value * 130),
              child: Transform(
                transform: Matrix4.rotationZ(
                    getRadiansFromDegree(rotationAnimation.value))
                  ..scale(degTwoTranslationAnimation.value),
                alignment: Alignment.center,
                child: CircularButton(
                  color: const Color.fromRGBO(0, 129, 174, 1),
                  width: 60,
                  height: 60,
                  image: 'assets/icons/notification.png',
                  title: 'notification_label'.tr,
                  onClick: () {
                    widget.closeAnimatedCircle!();
                    animationController.reverse();
                  },
                ),
              ),
            ),
            Transform.translate(
              offset: Offset.fromDirection(getRadiansFromDegree(205),
                  degThreeTranslationAnimation.value * 130),
              child: Transform(
                transform: Matrix4.rotationZ(
                    getRadiansFromDegree(rotationAnimation.value))
                  ..scale(degThreeTranslationAnimation.value),
                alignment: Alignment.center,
                child: CircularButton(
                  color: const Color.fromRGBO(0, 129, 174, 1),
                  width: 60,
                  height: 60,
                  image: 'assets/icons/blackbox.png',
                  title: 'blackbox_messages_label'.tr,
                  onClick: () {
                    widget.closeAnimatedCircle!();
                    animationController.reverse();
                    Get.toNamed('/blackbox');
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => MessageListScreen(),
                    //   ),
                    // );
                  },
                ),
              ),
            ),
            Transform.translate(
              offset: Offset.fromDirection(getRadiansFromDegree(170),
                  degForthTranslationAnimation.value * 130),
              child: Transform(
                transform: Matrix4.rotationZ(
                    getRadiansFromDegree(rotationAnimation.value))
                  ..scale(degForthTranslationAnimation.value),
                alignment: Alignment.center,
                child: CircularButton(
                  color: const Color.fromRGBO(0, 129, 174, 1),
                  width: 60,
                  height: 60,
                  image: 'assets/icons/trip-history.png',
                  // title: widget.trip != null ? 'Trip Summary' : 'Trip History',
                  title: 'trip_history_label'.tr,
                  onClick: () {
                    widget.closeAnimatedCircle!();
                    animationController.reverse();
                    // if (widget.trip != null) {
                    //   viewTripSummary();
                    // } else {
                    //   showTripsModal(context, 'COM', 'Trip History');
                    // }
                  },
                ),
              ),
            ),
            Transform(
              transform: Matrix4.rotationZ(
                  getRadiansFromDegree(rotationAnimation.value)),
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  if (animationController.isCompleted) {
                    animationController.reverse();
                    widget.closeAnimatedCircle!();
                  } else {
                    animationController.forward();
                    widget.openAnimatedCircle!();
                  }
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(255, 183, 0, 1),
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(18),
                  width: 60,
                  height: 60,
                  child: !animationController.isCompleted
                      ? const Image(
                          image: AssetImage('assets/icons/drawer.png'),
                          width: 12,
                        )
                      : const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 20,
                        ),
                ),
              ),
            )
          ],
        ));
  }
}
