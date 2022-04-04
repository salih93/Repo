import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/octicons_icons.dart';
import 'package:sdrmobil/Screens/Raporlar/raporlar_ana_menu.dart';
import 'package:sdrmobil/components/ListTileW.dart';
import 'package:sdrmobil/controller/controller.dart';
import 'package:get/get.dart';
import 'package:typicons_flutter/typicons_flutter.dart';

class Menuwidget extends StatelessWidget { 
  
  const Menuwidget({
    Key key,
    @required this.imageUrl,
    @required this.firmaadi,
    @required this.temsilciadi,
    @required this.temsilcikodu
  }) : super(key: key);

  final String imageUrl;
  final String firmaadi;
  final String temsilciadi;
  final String temsilcikodu;  

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Controller _controller = Get.find();

    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: size.height * 0.132,
            child: DrawerHeader(child: Text(""),
                decoration: BoxDecoration(
                color: Color(0xff009068),              
              ),
              
            ),
          ),
          ListTileW(
            icon: Octicons.dashboard,
            baslik: "Dashboard",
            sayfa: "dashboard",
            renk: Color(0xff009068),
            onTop: () async {       
              Navigator.of(context).pop();
              _controller.menuGoruntule.value=0;               
              _controller.update();                            
            }
          ),
          SizedBox(height: size.height * 0.01,),
          ListTileW(
            icon: Elusive.location,            
            baslik: "Müşteri Ziyareti",
            sayfa: "musteriziyaret",
            renk: Color(0xff009068),            
            onTop: (){
              // if(_controller.ziyaretId.value==0 || _controller.ziyaretId.value==null)
              // {
                Navigator.of(context).pop();
                _controller.menuGoruntule.value=1;
                _controller.update();                
              //}                 
            },
          ),
          SizedBox(height: size.height * 0.01,),
          ListTileW(
            icon: Typicons.shopping_cart,
            renk: Color(0xff009068),
            baslik: "Siparişler",
            sayfa: "siparisler",            
            onTop: () async {
              Navigator.of(context).pop();
              _controller.menuGoruntule.value=2;              
              _controller.update();              
              },
          ),
          SizedBox(height: size.height * 0.01,),
          ListTileW(
            icon: FontAwesome5.money_bill_wave,
            renk: Color(0xff009068),
            baslik: "Tahsilatlar",
            sayfa: "tahsilatlar",            
            onTop: (){              
               _controller.menuGoruntule.value=3;
               _controller.update();
              Navigator.pop(context);},
          ),
          SizedBox(height: size.height * 0.01,),
          ListTileW(
            icon: Typicons.document_text,
            renk: Color(0xff009068),
            baslik: "Raporlar",
            sayfa: "raporlar",
            onTop: (){              
                Navigator.of(context).pop();
                Get.to(()=>RaporlarAnaMenu());                
            },
          ),          
          
          SizedBox(height: size.height * 0.01,),

          
          ListTileW(
            icon: Typicons.export,
            renk: Color(0xff009068),
            baslik: "Aktarımlar",
            sayfa: "aktarimlar",
            onTop: ()async{
              if(_controller.ziyaretId.value==0 || _controller.ziyaretId.value==null)
              {                 
                await _controller.getToplamTahsilat();
                await _controller.getAllSiparisCount();
                await _controller.siparisTahsilatControl();
                Navigator.of(context).pop();                
                _controller.menuGoruntule.value=6;              
                _controller.update();
                
              }
            },
          ),
          SizedBox(height: size.height * 0.01,),
          Container(height: 1, color: Colors.grey), //divider
          SizedBox(height: size.height * 0.01,),

          ListTileW(
            icon: Elusive.cog,
            renk: Color(0xff009068),
            baslik: "Ayarlar",
            sayfa: "ayarlar",
            onTop: (){
              Navigator.of(context).pop();              
              _controller.menuGoruntule.value=5;              
              _controller.update();              
            },
          ),
          SizedBox(height: size.height * 0.01,),
          ListTileW(
            icon: Elusive.off,
            renk: Colors.red,
            baslik: "Çıkış",
            sayfa: "cikis",            
            onTop: (){
              if (Platform.isIOS) 
              {
                try {
                  //_controller.menuGoruntule.value=0;
                  exit(0); 
                } 
                catch (e) {
                  Navigator.maybeOf(context);
                  SystemNavigator.pop(); // for IOS, not true this, you can make comment this :)
                  exit(0);
                }
              }
              else
              {
                try 
                {
                  //_controller.menuGoruntule.value=0;
                  Navigator.maybeOf(context);                  
                  SystemNavigator.pop(); // sometimes it cant exit app  
                  exit(0);
                } 
                catch (e) 
                {
                  exit(0); // so i am giving crash to app ... sad :(
                }
              }          
            },
          ),
          //Container(height: 1, color: Colors.grey), //divider
        ],
      ),
    );
  }
}
