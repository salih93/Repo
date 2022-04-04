import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sdrmobil/constants.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final TextInputType textType; 
  final List<TextInputFormatter> inputFormat;
  final Function onTap;
  final bool readOnly;
  final FocusNode focusNode;
  final bool autoFocus;
  final double fontoran;

  const InputField({
    Key key,
    this.controller,
    this.hintText,
    this.icon,
    this.onChanged,
    this.textType,
    this.inputFormat,
    this.onTap,
    this.readOnly=false,
    this.focusNode,
    this.autoFocus=false,
    this.fontoran=ksiparisoran
  }) : super(key: key);

  

  @override
  Widget build(BuildContext context) {   
    Size size = MediaQuery.of(context).size;

    return TextField(                  
        keyboardType: textType,        
        controller: controller,
        onChanged: onChanged,
        cursorColor: Color(0xff009068),                
        style: TextStyle(fontSize: size.height * fontoran),
        inputFormatters: inputFormat,
        textInputAction: TextInputAction.done,       
        autofocus: autoFocus,
        onTap: onTap,
        readOnly: readOnly,
        focusNode: focusNode,
        obscureText: false,
        showCursor: true,
        decoration: InputDecoration(          
          // icon: (icon!=null) ? Icon(
          //   icon,
          //   color: Color(0xff009068),            
          // ):Text('', style: TextStyle(fontSize: 16),),
          
          hintText: hintText,
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: size.height * fontoran),                    
        ),
    );
  }
}
