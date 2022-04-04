import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:sdrmobil/Screens/Login/login_screen.dart';
import 'package:sdrmobil/Screens/Program/program.dart';
import 'package:sdrmobil/components/get_snackbar.dart';
import 'package:sdrmobil/components/rounded_password_field.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/controller/controller.dart';

class AyarlarSifreDegistirme extends StatelessWidget {
  const AyarlarSifreDegistirme({Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Controller _controller =Get.find();
    
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff009068),           
        title: Text("Şifre Değiştirme", style: TextStyle(fontSize: size.height * kRaporOranBaslik),),

        leading: IconButton(icon: Icon(Icons.arrow_back), color: Colors.white,
          iconSize: size.height * kRaporFiltereOran,
          onPressed:()async{
            await _controller.getAktarilmamisZiyaret();            
            _controller.menuGoruntule.value=5;
            _controller.update();
            Navigator.of(context).pop();
            Get.to(()=>ProgramPage());
          },
        ),

        actions: [
          Row(              
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(padding:EdgeInsets.only(right: 10) ,child: Image.asset(
                'assets/images/sdr-upbar-logo-icon.png',
                fit: BoxFit.contain,
                height: 40,
              ),
              ),
            ],
          ),
        ],
      ),
      body:Container(
        height: size.height * 0.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: size.height * 0.015,),
            RoundedPasswordField(
              controller: _controller.eskiPasswordController,
              hintText: "Eski Şifre",
              onChanged: (value) {},
              fontsize: size.height * kScreenOran2,
            ),
            SizedBox(height: size.height * 0.015,),

            RoundedPasswordField(
              controller: _controller.yeniPasswordController,
              hintText: "Yeni Şifre",
              onChanged: (value) {},
              fontsize: size.height * kScreenOran2,
            ),

            SizedBox(height: size.height * 0.015,),

            RoundedPasswordField(
              controller: _controller.yeniPasswordTekrarController,
              hintText: "Yeni Şifre Tekrar",
              onChanged: (value) {},
              fontsize: size.height * kScreenOran2,
            ),

            Card(
              child: Column(
                children: [
                  ListTile(
                    title:Container(
                      height: size.height * 0.06,
                      child: TextButton(
                        style: TextButton.styleFrom(                        
                          textStyle: TextStyle(fontSize: size.height * kScreenOran2),
                          backgroundColor: Color(0xff009068),
                        ),

                        child: Text("Şifre Değiştir", style: TextStyle(color: Colors.white, fontSize: size.height * kScreenOran2,),),
                        onPressed:()async{
                          if (_controller.eskiPasswordController.text=="" || _controller.eskiPasswordController.text==null)
                            {snackbar('Hata', 'Eski şifre girmelisiniz.', Icons.error); return;}
                          if (_controller.yeniPasswordController.text=="" || _controller.yeniPasswordController.text==null)
                            {snackbar('Hata', 'Yeni şifre girmelisiniz.', Icons.error); return;}
                          if (_controller.yeniPasswordTekrarController.text=="" || _controller.yeniPasswordTekrarController.text==null)
                            {snackbar('Hata', 'Yeni şifre tekrar girmelisiniz.', Icons.error); return;}

                          if (_controller.eskiPasswordController.text!=_controller.pass.value)
                            {snackbar('Hata', 'Eski şifre hatalı', Icons.error);return;}
                          if (_controller.yeniPasswordController.text!=_controller.yeniPasswordTekrarController.text)
                            {snackbar('Hata', 'Yeni şifre tekrar hatalı', Icons.error);return;}

                          var data = {};
                          data["Id"]=_controller.userid.value;
                          data["email"] = _controller.email.trimRight();
                          data["password"] = _controller.yeniPasswordController.text;
                          data["firma_id"] = _controller.firmaid.value;
                          data["pasif"]=false;                          
                          

                          var url = Uri.parse("http://sdrmobil.acilimsoft.com/Merkez/user/Update");
                          Map<String, String> headers = {"Content-type": "application/json"};
                          String _data = json.encode(data);
                          
                          var response = await post(url, 
                            headers: headers,
                            body: _data);
                          if (response.statusCode == 200) {
                            snackbar('Bilgi', 'Başarıyla şifre değiştirildi.', Icons.thumb_up);
                            Navigator.of(context).pop();
                            Get.to(()=> LoginScreen());
                          }
                          else
                          {
                            snackbar('Hata', 'Şifre değiştirilemedi.', Icons.error);
                            return;
                          }

                        }
                      ),
                    ),
                  ),
                ],  
              ),
            ),

          ],
        ),
      ),


    );
  }
}