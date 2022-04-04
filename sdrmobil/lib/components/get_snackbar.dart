
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdrmobil/constants.dart';

void snackbar(String _baslik, String _message, IconData _icon)
{
  Size size = MediaQuery.of(Get.context).size;

    Get.snackbar("","",
                titleText: Text(_baslik, style: TextStyle(fontSize: size.height * kSnackBarOranBaslik, color: Colors.white),),
                messageText: Text(_message, style: TextStyle(fontSize: size.height * kSnackBarOran, color: Colors.white),),
                borderRadius: 20,                
                icon: _icon!=null ? Icon(_icon, color: Colors.white): Icons.person,
                snackPosition: SnackPosition.BOTTOM,
                snackStyle: SnackStyle.FLOATING,
                backgroundColor: Color(0xff009068),
                colorText: Colors.white,
                duration: Duration(seconds: 5),
                
          );
    
   

}