
import 'package:flutter/material.dart';
import 'package:sdrmobil/widget_keyboard/key_data.dart';
import 'package:sdrmobil/widget_keyboard/key_types.dart';

class GenericKeys {
  static List<KeyData> numericKeys = [
    KeyData(type: KeyType.textKey, normalText: "0"),
    KeyData(type: KeyType.textKey, normalText: "1"),
    KeyData(type: KeyType.textKey, normalText: "2"),
    KeyData(type: KeyType.textKey, normalText: "3"),    
    KeyData(type: KeyType.textKey, normalText: "4"),
    KeyData(type: KeyType.textKey, normalText: "5"),
    KeyData(type: KeyType.textKey, normalText: "6"),
    KeyData(type: KeyType.textKey, normalText: "7"),
    KeyData(type: KeyType.textKey, normalText: "8"),
    KeyData(type: KeyType.textKey, normalText: "9"),    
    KeyData(type: KeyType.specialKey, normalIcon: Icons.label_outline, normalText:"" ),
    

  ];

  static List<String> qwertyKeys = ["q", "w", "c"];
}
