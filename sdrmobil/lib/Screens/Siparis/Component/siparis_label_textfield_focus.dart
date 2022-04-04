import 'package:flutter/material.dart';
import 'package:sdrmobil/components/label_text_field.dart';

class SiparisLabelTextFieldFocus extends StatelessWidget {
  const SiparisLabelTextFieldFocus({
    Key key,
    @required this.size,
    @required this.controller,
    this.maxLines=1
  }) : super(key: key);

  final Size size;
  final TextEditingController controller;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return LabelTextField(fontsize: size.width * 0.045,textAlign: TextAlign.start,
      labelsize: size.width * 0.045, controller: controller,                            
      inputType: TextInputType.multiline, autofocus: true, maxLines: maxLines,
    );
  }
}
