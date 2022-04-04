import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LabelTextField extends StatelessWidget {
  const LabelTextField({
    Key key,
    this.labelsize,
    this.fontsize,
    this.labelText,
    this.textAlign,
    this.inputType,
    this.readOnly=false,
    this.autofocus=false,
    this.inputFormat,
    this.controller,
    this.onChanged,
    this.onTap,
    this.maxLines=1,
  }) : super(key: key); 
  final double labelsize; 
  final double fontsize;
  final String labelText;
  final TextAlign textAlign;
  final TextInputType inputType;
  final bool readOnly;
  final bool autofocus;
  final List<TextInputFormatter> inputFormat;
  final TextEditingController controller;
  final Function onChanged;
  final Function onTap;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    
    return SingleChildScrollView(
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        style: TextStyle(fontSize: fontsize),
        keyboardType: inputType,
        inputFormatters: inputFormat,
        textAlign: textAlign,
        readOnly: readOnly,
        autofocus: autofocus,
        onTap: onTap,
        maxLines: maxLines,      
        decoration: InputDecoration(                              
          labelText: labelText,
          contentPadding: EdgeInsets.all(5),
          isDense: true,
          border: OutlineInputBorder(),
          labelStyle: TextStyle(fontSize: labelsize),        
        ),
      
      ),
    );
  }
}