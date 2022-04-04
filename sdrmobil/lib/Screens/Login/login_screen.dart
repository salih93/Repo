import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sdrmobil/Screens/Login/components/body.dart';
import 'package:sdrmobil/controller/controller.dart';
import 'package:sdrmobil/controller/siparis_controller.dart';
import 'package:sdrmobil/controller/tahsilat_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key key}):super(key:key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    final Controller _controller = Get.put(Controller());
    final SiparisController siparisController = Get.put(SiparisController());
    final TahsilatController tahsilatController = Get.put(TahsilatController());
    _controller.deleteDatabase.value=0;
        
    print(siparisController.cbirim.text);
    print(tahsilatController.aciklamaController.text);
              
    return Obx(()=>Scaffold(
      body: (!_controller.isLoading.value) ? Body():Center(child: CircularProgressIndicator(color: Color(0xff009068))),
      ),
    );

  }
}
