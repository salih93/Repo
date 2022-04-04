
import 'package:flutter/material.dart';
//import 'package:flutter_auth/components/text_field_container.dart';


class TextFieldLink extends StatelessWidget {  
  final String baslik;
  final Function onTap; 
  final double fontSize;

  const TextFieldLink({ Key key,         
    this.baslik,
    this.onTap, 
    this.fontSize
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(        
        //margin: EdgeInsets.symmetric(vertical:1),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        width: size.width * 0.8,
        height: size.height * 0.055,
        decoration: BoxDecoration(
        //color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(10),
          ),

        child: ListTile(
          title: Text(baslik, 
          style: TextStyle(fontSize: fontSize,
            decoration: TextDecoration.underline,            
            ),            
          ),

          onTap: onTap,
          autofocus: false,
          dense: true,          
        ),
        
    );            
    
  }
}