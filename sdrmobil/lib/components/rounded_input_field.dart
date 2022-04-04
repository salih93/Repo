
import 'package:flutter/material.dart';
import 'package:sdrmobil/components/text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final double fontsize;
  const RoundedInputField({
    Key key,
    this.controller,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
    this.fontsize
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return TextFieldContainer(
      child: TextFormField(        
        controller: controller,
        onChanged: onChanged,
        cursorColor: Color(0xff009068),
        decoration: InputDecoration( 
          //isCollapsed: true,         
          //isDense: true,          
          icon: Icon(
            icon,
            color: Color(0xff009068),
            size: size.height * 0.028,
          ),
          hintText: hintText,
          border: InputBorder.none,                    
        ),
        style: TextStyle(fontSize: fontsize),
      ),
    );
  }
}
