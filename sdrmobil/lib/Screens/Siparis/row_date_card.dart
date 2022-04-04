import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    this.autoFocus=false
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Card(child: 
          ListTile(
          dense: false,          
          title: Row(
            children: [
              Expanded(flex: 3,child:Column( 
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,                     
                  children: [
                     Text(inputText,style: TextStyle(fontSize: 14),),       
                  ],
                ),
              ),
                                      
              Expanded(flex: 4,child:Column( 
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,                     
                  children: [
                    InputDatePickerFormField(
                      firstDate: DateTime(2000),
                      lastDate: DateTime(DateTime.now().year + 50),
                    ),
                    
      
                    // InputField(
                    //   textType: textType,
                    //   controller: controller,
                    //   hintText: hintText,
                    //   onChanged: onChanged,
                    //   inputFormat:inputFormat,
                    //   focusNode: focusNode,
                    //   onTap: onTap,
                    //   readOnly: readOnly, 
                    //   autoFocus: autoFocus,        
                    // ),                                                      
                  ],
                ),
              ),

            ],
          ),
        
        ),
      );
  }
}