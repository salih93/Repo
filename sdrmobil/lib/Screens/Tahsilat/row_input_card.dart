import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sdrmobil/components/input_field.dart';
import 'package:sdrmobil/constants.dart';

class RowInputCard extends StatelessWidget {
  final TextEditingController controller;
  final String inputText;
  final String hintText;
  final Function onChanged;
  final TextInputType textType; 
  final Widget widgetHata;
  final List<TextInputFormatter> inputFormat;
  final Function onTap;
  final bool readOnly;
  final FocusNode focusNode;
  final bool autoFocus;
  final double fontoran;
  
  const RowInputCard({Key key, 
    this.controller, 
    this.inputText,
    this.hintText,
    this.onChanged,
    this.textType,
    this.widgetHata,
    this.inputFormat,
    this.onTap,
    this.readOnly,
    this.focusNode,
    this.autoFocus=false,
    this.fontoran=ksiparisoran
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Card(child: 
          ListTile(
          dense: false,          
          contentPadding: EdgeInsets.only(left: size.width * fontoran),
          title: Row(
            children: [
              Expanded(flex: 3,child:Column( 
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,                     
                  children: [
                     Text(inputText,style: TextStyle(fontSize: size.height * fontoran),),       
                  ],
                ),
              ),
                                      
              Expanded(flex: 4,child:Column( 
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,                     
                  children: [
                    InputField(
                      textType: textType,
                      controller: controller,
                      hintText: hintText,
                      onChanged: onChanged,
                      inputFormat:inputFormat,
                      focusNode: focusNode,
                      onTap: onTap,
                      readOnly: readOnly, 
                      autoFocus: autoFocus,  
                      fontoran: fontoran,                            
                    ),                                                      
                  ],
                ),
              ),

            ],
          ),
          //subtitle: widgetHata,
        ),
      );
  }
}