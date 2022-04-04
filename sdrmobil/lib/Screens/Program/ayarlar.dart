
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdrmobil/Screens/Program/ayarlar_sifre_degistirme.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/controller/controller.dart';

class Ayarlar extends StatelessWidget {
  
  const Ayarlar({Key key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Controller _controller = Get.find();
    
    return SingleChildScrollView(
        child: Column(          
          children: [
            //SizedBox(height: size.height * 0.01,),
            Center(
              child: Card(
                child: ListTile(
                  title:Container(
                    height: size.height * 0.06,
                    child: TextButton(
                      style: TextButton.styleFrom(                        
                        textStyle: TextStyle(fontSize: size.height * kaktarimbasoran),
                        backgroundColor: Color(0xff009068),
                      ),
                      child: Text("Şifre Değiştir", style: TextStyle(color: Colors.white),),
                      onPressed:() {
                        _controller.eskiPasswordController.text="";
                        _controller.yeniPasswordController.text="";
                        _controller.yeniPasswordTekrarController.text="";
                        
                        Navigator.of(context).pop();
                        Get.to(()=> AyarlarSifreDegistirme());
                      }

                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      

      
    );

  }
}



