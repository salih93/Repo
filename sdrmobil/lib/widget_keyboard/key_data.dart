import 'package:flutter/material.dart';
import 'package:sdrmobil/widget_keyboard/key_types.dart';

class KeyData {
  KeyType type;
  String normalText;
  String alternativeText;
  IconData normalIcon;
  IconData alternativeIcon;
  bool keepPressed;

  KeyData(
      {this.normalIcon,
      this.keepPressed = true,
      this.alternativeIcon,
      @required this.type,
      @required this.normalText,
      this.alternativeText});
}
