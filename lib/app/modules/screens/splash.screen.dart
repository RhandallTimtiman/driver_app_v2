import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  double _height = 400;
  bool _isAnimating = false;
  bool _isHidden = true;
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      setState(() {
        _isAnimating = true;
        _height = 240;
      });
    });
    Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _isHidden = false;
      });
    });
    Timer(const Duration(milliseconds: 2500), () {
      setState(() {
        _isHidden = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          // color: Color.fromRGBO(42, 85, 118, 1),
          image: DecorationImage(
            image: AssetImage('assets/images/splash-bg.jpg'),
            fit: BoxFit.cover,
          ),
          gradient: RadialGradient(
            colors: [Color(0xff125A79), Color(0xff1D3E58)],
          ),
        ),
        child: Stack(
          children: [
            AnimatedOpacity(
              opacity: !_isHidden ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              child: Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  width: _height,
                  child: Image.asset(
                    'assets/images/x-icon.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            AnimatedOpacity(
              opacity: _isAnimating ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 1000),
              child: Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  width: _height,
                  child: Image.asset(
                    'assets/images/xlog.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
