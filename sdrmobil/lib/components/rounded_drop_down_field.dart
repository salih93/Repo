import 'package:flutter/material.dart';

class RoundedDropDownField extends StatelessWidget {
  final String controller;
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChangeds;
  final List<DropdownMenuItem<String>> itemS;
  final String valueS;
  const RoundedDropDownField({
    Key key,
    this.controller,
    this.hintText,
    this.icon = Icons.person,
    this.onChangeds,
    this.itemS,
    this.valueS
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {

     return Center(child:DropdownButtonFormField<String>(
            value: controller,
            items: itemS,            
            //hint: Text(hintText),
            onChanged:onChangeds,
            decoration: InputDecoration(
              icon: Icon(
                icon,
                color: Color(0xff009068),
              ),
              hintText: hintText,
              border: InputBorder.none,
            ),            
          ),
      );



  }
}
