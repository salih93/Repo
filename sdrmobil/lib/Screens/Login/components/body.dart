import 'package:flutter/material.dart';
import 'package:sdrmobil/Screens/Login/components/background.dart';
import 'package:sdrmobil/Screens/Login/components/sifremi_unuttum.dart';
import 'package:sdrmobil/Screens/Login/components/signIn.dart';
import 'package:sdrmobil/Screens/Login/veritabani_sifirlama_ekrani.dart';
import 'package:sdrmobil/components/get_snackbar.dart';
import 'package:sdrmobil/components/rounded_button.dart';
import 'package:sdrmobil/components/rounded_checkbox.dart';
import 'package:sdrmobil/components/rounded_input_field.dart';
import 'package:sdrmobil/components/rounded_password_field.dart';
import 'package:sdrmobil/components/text_field_link.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/controller/controller.dart';
import 'package:get/get.dart';
import 'package:sdrmobil/providers/db_provider.dart';
 
class Body extends StatelessWidget {
  Body({Key key}):super(key: key);
  final Controller _controller = Get.put(Controller());
  

  @override
  Widget build(BuildContext context) {
    
    Size size = MediaQuery.of(context).size;
  
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[            
            
            SizedBox(height: size.height * 0.03),
            
            Image.asset('assets/icons/sdr-mobil-logo.png',height: size.height * 0.25,),

            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              controller: _controller.emailController,
              hintText: "Email Adresi",
              onChanged: (value) {},
              fontsize: size.height * kScreenOran,
            ),
            SizedBox(height: size.height * 0.02),

            RoundedPasswordField(
              controller: _controller.passwordController,
              hintText: "Şifre",
              onChanged: (value) {},       
              fontsize: size.height * kScreenOran,
            ),
            
            SizedBox(height: size.height * 0.02),

            Obx(()=>RoundedCheckBoxField( 
                baslik: 'Beni Hatırla',
                isChecked: _controller.getBeniHatirla(),              
                onChanged:(bool value){                
                    _controller.changeBeniHatirla();                
                },
                fontsize: size.height * kScreenOran,
              ),
            ),
            SizedBox(height: size.height * 0.02),
            TextFieldLink(              
              baslik: "Şifremi Unuttum",              
              onTap: (){
                //createDirectory();
                Get.to(()=>SifremiUnuttum());            
              },
              fontSize: size.height * kScreenOran,
            ),
            
            SizedBox(height: size.height * 0.03),
            RoundedButton(
              fontsize: size.height * kScreenOran,
              text: "Giriş",
              textColor: Colors.white,
              press: () {
                  if (_controller.emailController.text == "" || _controller.emailController.text == null)
                  {                     
                      snackbar("Login","Email adresi girmelisiniz.", Icons.person);
                      return;
                  }

                  if (_controller.passwordController.text == "" || _controller.passwordController.text == null)
                  {
                      snackbar("Login","Şifre girmelisiniz.", Icons.person);                      
                      return;
                  }

                  signIn(_controller.emailController.text, _controller.passwordController.text, context);
                },
            ),

            
          ],
        ),
      ),
      veritabaniSifirla: 1,
      onTap: () async {
        _controller.deleteDatabase.value=0;
        _controller.veritabaniGuncelle.text="";
        
        await Get.defaultDialog(
          title: "Dikkat",                
          backgroundColor: Colors.white,
          titleStyle: TextStyle(color: Colors.red),
          middleTextStyle: TextStyle(color: Colors.black),                                
          textConfirm: "Tamam",
          textCancel: "İptal",
          cancelTextColor: Colors.black,
          confirmTextColor: Colors.black,
          barrierDismissible: false,
          radius: 1,                
          content: VeritabaniSifirlamaW(),                
          onConfirm: () async {
            
            if (_controller.veritabaniGuncelle.text.toLowerCase()=="evet")
            {
              _controller.boxStorage.value.write("beniHatirla", 0);              
              _controller.boxStorage.value.write("email", ""); //kullanıcının değiştiğini anlamak için.
              _controller.boxStorage.value.write("password", "");
              _controller.emailController.text="";
              _controller.passwordController.text="";
              _controller.beniHatirla.value=false;
              
              _controller.deleteDatabase.value=1;
              await DBProvider.deleteDatabases();
            }
            Navigator.of(context).pop(false);
          },
          onCancel: () async {                  
            _controller.deleteDatabase.value=0;
          }
        );

      },


    );
  } 
}



