import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sdrmobil/widget_keyboard/custom_input_keyboard.dart';
import 'package:sdrmobil/widget_keyboard/custom_key.dart';
import 'package:sdrmobil/widget_keyboard/custom_keyboard.dart';
import 'package:sdrmobil/widget_keyboard/generic_keys.dart';
import 'package:sdrmobil/widget_keyboard/key_controller.dart';
import 'package:sdrmobil/widget_keyboard/key_data.dart';
import 'package:sdrmobil/widget_keyboard/key_types.dart';

class NumericInputKeyboard extends StatefulWidget {
  final bool floatingPoint;
  final TextEditingController controller;  
  final String errorText;
  final Function(BuildContext) onSubmit;  
  final Future<bool> Function(String) validator;
  final FilteringTextInputFormatter inputFormat;  
  final FocusNode focusNode;
    
  const NumericInputKeyboard(
      {@required this.controller,
      this.onSubmit,
      this.validator,      
      this.errorText = "Invalid format",
      this.floatingPoint = true,
      this.inputFormat,
      this.focusNode,
      Key key})
      : super(key: key);

  @override
  State<NumericInputKeyboard> createState() => _NumericInputKeyboardState();
}

class _NumericInputKeyboardState extends State<NumericInputKeyboard> {
  KeyboardController keyboardController;
  bool visible=true;
  
  @override
  void initState() {
    super.initState();
    //SystemChannels.textInput.invokeMethod('TextInput.hide');    
    keyboardController = KeyboardController();
  }



  @override
  Widget build(BuildContext context) {
    
    return CustomInputKeyboard(
      validator: widget.validator,
      onSubmit: widget.onSubmit,            
      errorText: widget.errorText,
      focusNode: widget.focusNode,
      keyboard: CustomKeyboard(
        keyboardController: keyboardController,
        rowKeys: [..._numericRows()],              
      ),
    controller: widget.controller);      
  }

  Future<bool> validator(String text) async {
    return text.length > 3;
  }

  List<List<CustomKey>> _numericRows() {
    List<List<CustomKey>> keys = [];
    int currentKey = 1;
    for (int i = 0; i < 4; i++) {

      List<CustomKey> row = [];
      for (int j = 0; j < 4; j++) {        
        
        if (j!=3 && i!=3)
        {
          //final FocusNode focusNode = new FocusNode();

          row.add(CustomKey(
            keyboardController: keyboardController,
            keyData: GenericKeys.numericKeys[currentKey],
            onDataInput: onNumberInput,
            //focusNode: AlwaysDisabledFocusNode(),
            ));
          currentKey++;
        }
        else
        {
          if(i==0)
          {
            

            row.add(CustomKey(
              keyboardController: keyboardController,
              keyData: KeyData(
                type: KeyType.specialKey,
                normalText: "",
                normalIcon: Icons.backspace_outlined,
              ),
              onSpecialCallback: onDeleteCallback,
              onDataInput: (_) async {},
              //focusNode: AlwaysDisabledFocusNode(),
            ));
            
          }
          if(i==1)
          {           

            row.add(CustomKey(
              keyboardController: keyboardController,
              keyData: KeyData(type: KeyType.specialKey, normalText: "", 
                normalIcon: Icons.indeterminate_check_box_rounded),
              onDataInput: onNumberInput,
              //focusNode: AlwaysDisabledFocusNode(),
            ));
          }
          if(i==2)
          {
            
            row.add(CustomKey(
              keyboardController: keyboardController,
              keyData: KeyData(type: KeyType.specialKey, normalText: "", 
              normalIcon: FontAwesomeIcons.angleDoubleLeft,),
              onSpecialCallback: onDeleteAllCallback,
              onDataInput: onNumberInput,
            //focusNode: AlwaysDisabledFocusNode(),
            ));
          }

          if(i==3 && j==0)
          {
          

             row.add(CustomKey(
              keyboardController: keyboardController,
              keyData: KeyData(type: KeyType.specialKey, normalText: ","),
              onSpecialCallback: onDecimalPointInput,
              onDataInput: (_) async {},
              //focusNode: AlwaysDisabledFocusNode(),
              ));
          }
          if(i==3 && j==1)
          {
              row.add(CustomKey(
                keyboardController: keyboardController,
                keyData: GenericKeys.numericKeys[0],
                onDataInput: onNumberInput,
                //focusNode: AlwaysDisabledFocusNode(),
              ), 
            );
          }

          if(i==3 && j==2)
          {
            
            row.add(CustomKey(
              keyboardController: keyboardController,
              keyData: KeyData(type: KeyType.specialKey, normalText: "."),
              onSpecialCallback: onFloatingPointInput,
              onDataInput: (_) async {},
              //focusNode: AlwaysDisabledFocusNode(),
            ));          
          }

          if(i==3 && j==3)
          {
              row.add(CustomKey(
                keyboardController: keyboardController,
                keyData: KeyData(
                  type: KeyType.specialKey,
                  normalText: "",
                  normalIcon: Icons.check_outlined,
                ),
                onSpecialCallback: onCloseInput,
                onDataInput: (_) async {},
                //focusNode: AlwaysDisabledFocusNode(),
                )
              );
          }

        } 

      }
      keys.add(row);
    }
    return keys;
  }




  onNumberInput(String keyText) {
    final text = widget.controller.text;
    final newText = text + keyText;
    widget.controller.text = newText;
  }

  onDeleteCallback() {
    final text = widget.controller.text;
    if (text.isNotEmpty) {
      final newText = text.substring(0, text.length - 1);
      widget.controller.text = newText;
    }
  }
  
  onDeleteAllCallback() {
    final text = widget.controller.text;
    if (text.isNotEmpty) {      
      widget.controller.text = "";
    }
  }
  
  onDecimalPointInput() {        
    final text = widget.controller.text;
    String patern = widget.inputFormat.filterPattern.toString();
    

    if (!text.contains(",") && patern.contains(',')) {
      final newText = text + ",";
      widget.controller.text = newText;
    }
  }

  onFloatingPointInput() {
    final text = widget.controller.text;
    String patern = widget.inputFormat.filterPattern.toString();

    if (!text.contains(".") && patern.contains('.')) {
      final newText = text + ".";
      widget.controller.text = newText;
    }
  }

  onCloseInput() {
    setState(() {
      visible=false;
    });
  }

  onShiftInput() {
    keyboardController?.alternateKeys();
    setState(() {});
  }

  onSwitchInput() {
    keyboardController?.switchKeys();
    setState(() {});
  }
}
