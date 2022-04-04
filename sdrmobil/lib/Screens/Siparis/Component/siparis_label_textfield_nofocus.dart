import 'package:flutter/material.dart';
import 'package:sdrmobil/components/label_text_field.dart';
import 'package:flutter/services.dart';
import 'package:sdrmobil/constants.dart';

class SiparisLabelTextFieldNoFocus extends StatelessWidget {
  const SiparisLabelTextFieldNoFocus({
    Key key,
    this.labelText,
    @required this.size,
    @required this.controller,
    this.maxLines=1,
    this.onTap,    
    this.readOnly,
    this.decimal, 
    this.onChanged
  }) : super(key: key);

  final Size size;
  final TextEditingController controller;
  final int maxLines;
  final Function onTap;
  final Function onChanged;
  final bool readOnly;
  final String decimal;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return LabelTextField(labelText: labelText, fontsize: size.height * ksiparisoran,textAlign: TextAlign.start,
      labelsize: size.height * ksiparisoran, controller: controller,                            
      maxLines: maxLines,
      onTap: onTap,
      onChanged: onChanged,
      readOnly: readOnly,
      inputType: TextInputType.number,
      inputFormat: [FilteringTextInputFormatter.deny(RegExp('[^0-9$decimal]'), ),],
    );
  }
}

