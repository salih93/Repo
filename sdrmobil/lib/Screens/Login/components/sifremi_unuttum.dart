
import 'package:flutter/material.dart';
import 'package:sdrmobil/Screens/Login/components/background.dart';
import 'package:sdrmobil/Screens/Login/components/sifre_gonder.dart';
import 'package:sdrmobil/components/rounded_button.dart';
import 'package:sdrmobil/components/rounded_input_field.dart';
import 'package:get/get.dart';

class SifremiUnuttum extends StatelessWidget {
  SifremiUnuttum({Key key}):super(key:key);

  final TextEditingController emailController = new TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(
        child:SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                  SizedBox(height: size.height * 0.03),
                  RoundedInputField(
                    controller: emailController,
                    hintText: "Email Adresi",
                    onChanged: (value) {},
                  ),

                  SizedBox(height: size.height * 0.03),
                  RoundedButton(
                    text: 'Şifre Gönder',
                    press:() {
                       if (emailController.text == "" || emailController.text == null)
                        {
                            Get.snackbar('Şifremi Unuttum', 'Email adresi girmelisiniz.');
                            return;
                        }
                        sifreGonder(emailController.text);
                    },
                  ),

              ],
            ),
          ),
        ),
    );
  }
}