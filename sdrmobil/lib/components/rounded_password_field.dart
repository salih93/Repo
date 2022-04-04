import 'package:flutter/material.dart';
import 'package:sdrmobil/components/text_field_container.dart';
import 'package:sdrmobil/constants.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  final String hintText;
  final double fontsize;
  const RoundedPasswordField({
    Key key,
    this.controller,
    this.onChanged,
    this.hintText="Şifre",
    this.fontsize
  }) : super(key: key);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
   bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return TextFieldContainer(
      child: TextField(
        controller: widget.controller,
        obscureText: _isObscure,
        onChanged: widget.onChanged,
        cursorColor: kPrimaryColor,
        style: TextStyle(fontSize: widget.fontsize),
        decoration: InputDecoration(
          hintText: widget.hintText,
          icon: Icon(
            Icons.lock,
            color: Color(0xff009068),
            size: size.height * 0.028,
          ),
          suffixIcon: IconButton(onPressed: (){
            setState(() {
              _isObscure = !_isObscure;
            });
          }, icon: Icon(
            _isObscure ? Icons.visibility : Icons.visibility_off, 
              color: Color(0xff009068),
              size: size.height * 0.028,
            ),            
          ), 
            
            border: InputBorder.none,            
        ),
          
        ),
      );    
  }
}
