import 'package:flutter/material.dart';
import 'package:sdrmobil/widget_keyboard/custom_key.dart';
import 'package:sdrmobil/widget_keyboard/key_controller.dart';


class CustomKeyboard extends StatefulWidget {
  final List<List<CustomKey>> rowKeys;
  final List<List<CustomKey>> shiftedRowKeys;
  final KeyboardController keyboardController;
  final Color color;
  final Color switchedColor;

  const CustomKeyboard(
      {this.shiftedRowKeys,
      this.keyboardController,
      this.color,
      this.switchedColor,
      @required this.rowKeys,
      Key key})
      : super(key: key);

  @override
  State<CustomKeyboard> createState() => _CustomKeyboardState();
}

class _CustomKeyboardState extends State<CustomKeyboard> {
  @override
  Widget build(BuildContext context) {

    return Container(      
      color: getColor(),
      child: Column(        
        children: _rowsBuilder(),
      ),
    );
  }

  Color getColor() {
    if (widget.keyboardController != null) {
      if (widget.keyboardController.isSwitched) {
        if (widget.switchedColor != null) {
          return widget.switchedColor;
        } else if (widget.color != null) {
          return widget.color;
        } else {
          return Colors.white;
        }
      } else {
        if (widget.color != null) {
          return widget.color;
        } else {
          return Colors.black12;
        }
      }
    }
    else{
      return Colors.white;
    }
  }

  List<List<CustomKey>> currentKeys() {
    if (widget.keyboardController != null) {
      if (widget.keyboardController.isSwitched) {
        return widget.shiftedRowKeys ?? widget.rowKeys;
      } else {
        return widget.rowKeys;
      }
    }
    return widget.rowKeys;
  }

  List<Widget> _rowsBuilder() {
    List<Widget> rows = [];
    List<List<CustomKey>> keys = currentKeys();
    for (int i = 0; i < keys.length; i++) {
      rows.add(
        Expanded(          
          child: Row(children: keys[i]),
      ));
    }
    return rows;
  }
}
