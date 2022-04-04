
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdrmobil/Screens/Aktar%C4%B1mlar/aktarimlar.dart';
import 'package:sdrmobil/Screens/Login/components/background.dart';
import 'package:sdrmobil/Screens/Program/ayarlar.dart';
import 'package:sdrmobil/Screens/Program/program_body.dart';
import 'package:sdrmobil/Screens/Raporlar/raporlar_ana_menu.dart';
import 'package:sdrmobil/Screens/Tahsilat/tahsilat_list.dart';
import 'package:sdrmobil/Screens/Siparis/siparis_tum_liste.dart';
import 'package:sdrmobil/Screens/Ziyaret/ziyaret_gunleri.dart';
import 'package:sdrmobil/components/background_scroll.dart';
import 'package:sdrmobil/controller/controller.dart';


  
  Widget getChild(){  
    
    Widget w=Background(child: ProgramBody());

    final Controller _controller = Get.find();
    if (_controller.menuGoruntule.value==1) {       
        w=BackgroundSroll(child:ZiyaretGunleri());
      }

      if (_controller.menuGoruntule.value==2) {
        w=Background(child:SiparisTumListe());
      }

      if (_controller.menuGoruntule.value==3) {
        w=Background(child:TahsilatList());        
      }
      if (_controller.menuGoruntule.value==4) {
        w=Background(child:RaporlarAnaMenu());
      }
      
      if (_controller.menuGoruntule.value==5) {
        w=Ayarlar();
      }
      if (_controller.menuGoruntule.value==6) {
        w=_controller.isAktarimlar.value==true ? Center(child:CircularProgressIndicator(color: Color(0xff009068))):Aktarimlar();
      }
      if (_controller.menuGoruntule.value<1 || _controller.menuGoruntule.value>6)
      {
        w=Background(child:ProgramBody());
      }

    return w;    
  }

