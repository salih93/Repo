import 'package:flutter/material.dart';
import 'package:sdrmobil/components/label_text_field.dart';
import 'package:flutter/services.dart';
import 'package:sdrmobil/constants.dart';

class SiparisLabelTextField extends StatelessWidget {
  const SiparisLabelTextField({
    Key key,
    @required this.size,
    @required this.controller,
    @required this.decimal,
  }) : super(key: key);

  final Size size;
  final TextEditingController controller;
  final String decimal;

  @override
  Widget build(BuildContext context) {
    return LabelTextField(fontsize: size.height * ksiparisoran, textAlign: TextAlign.end,
      labelsize: size.height * ksiparisoran, controller: controller,                            
      inputType: TextInputType.number,readOnly:true,
      inputFormat: [FilteringTextInputFormatter.deny(RegExp('[^0-9$decimal]'), ),],
    );
  }
}