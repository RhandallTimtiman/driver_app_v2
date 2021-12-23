import 'package:flutter/material.dart';

class Status {
  bool isOnline = false;
  bool isDisplayed = false;
  bool isDisabled = false;
  Widget? child;

  Status({
    this.isOnline = false,
    this.isDisabled = false,
    this.isDisplayed = false,
    this.child,
  });
}
