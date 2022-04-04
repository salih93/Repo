  import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sdrmobil/widget_keyboard/numeric_input_keyboard.dart';

showInputKeyboard(TextEditingController controller, BuildContext context, 
    FilteringTextInputFormatter inputFormat, FocusNode focusNode) async {
    //String txt = 
    await showModalBottomSheet<String>(
        context: context,
        isScrollControlled: true,
        useRootNavigator: true,        
        builder: (BuildContext context) {
          return NumericInputKeyboard(
            controller: controller,
            floatingPoint: true,
            validator: validateNumber,
            errorText: "Not long enough",
            inputFormat:inputFormat,
            focusNode:focusNode,            
            //labelText: "Long number",
          );          
        });
   
    }
    
    Future<bool> validateNumber(String str) async {
      return str.length > 4;
    }