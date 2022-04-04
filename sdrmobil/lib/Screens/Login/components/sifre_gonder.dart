
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sdrmobil/Screens/Login/components/sifremi_unuttum.dart';
import 'package:sdrmobil/Screens/Login/login_screen.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

void sifreGonder(String email) async {
  //Controller _controller = Get.put(Controller());
       

    var url = Uri.parse("http://sdrmobil.acilimsoft.com/Merkez/user/SifremiUnuttum");
    
    Map<String, String> headers = {"Content-type": "application/json"};

    var data = {};
    data["Id"] = 0; //önemli değil mailden userı buluyoruz.
    data["email"] = email.trimRight();
    data["pasif"]=false;

    String _data = json.encode(data);

    var response = await post(url, 
      headers: headers,
       body: _data);

    if (response.statusCode == 200) 
    {
      var jsonResponse;  
      jsonResponse = json.decode(response.body);

      if (jsonResponse != null) {
        var jsonResponse;      
        jsonResponse = json.decode(response.body);
        Get.snackbar("SDR Mobil",
                jsonResponse['message'],
                borderRadius: 20,
                icon: Icon(Icons.person, color: Colors.white),
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.green,
                colorText: Colors.white,
                duration: Duration(seconds: 1),
          );
      }
      Get.offAll(()=>SifremiUnuttum());
      Get.to(()=>LoginScreen());

    }
    else
    {
      var jsonResponse;
      print(response.toString());      

      jsonResponse = json.decode(response.body);
      Get.rawSnackbar(titleText: Text('Hata'), 
          messageText: Text(jsonResponse['message']),
          borderRadius: 20,
          icon: Icon(Icons.person, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,               
          backgroundColor: Colors.green,               
          borderColor: Colors.white,               
          duration: Duration(seconds: 3),
        );

    }

}