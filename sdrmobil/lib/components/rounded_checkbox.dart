
import 'package:flutter/material.dart';
//import 'package:flutter_auth/components/text_field_container.dart';


class RoundedCheckBoxField extends StatelessWidget {
  final ValueChanged<bool> onChanged;  
  final String baslik;
  final bool isChecked;
  final double horizontal;
  final double sizewidth;
  final double fontsize;

  const RoundedCheckBoxField({ Key key,    
    this.onChanged, 
    this.baslik, 
    this.isChecked,
    this.horizontal=20,
    this.sizewidth=0.8,
    this.fontsize
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return 
      Container(
        padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: 0),
        width: size.width * sizewidth,
        decoration: BoxDecoration(    
         borderRadius: BorderRadius.circular(29),
        ),

        child: Theme(          
          data: ThemeData(unselectedWidgetColor: Color(0xff009068),),                     
          
          child: CheckboxListTile(
            title: Text(baslik, style: TextStyle(color: Colors.black, fontSize:fontsize),),
            onChanged: onChanged,
            autofocus: false,
            dense: true,
            value: isChecked,
            selected: isChecked,               
            //checkColor: Colors.black,
            activeColor: Color(0xff009068),
            controlAffinity: ListTileControlAffinity.trailing,
          ),          
        ),

      );

         
    

  }
}