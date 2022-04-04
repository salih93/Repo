
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:sdrmobil/Screens/Program/program.dart';
import 'package:sdrmobil/Screens/Siparis/bekleyen_siparisler.dart';
import 'package:sdrmobil/Screens/Siparis/siparis_animated_button.dart';
import 'package:sdrmobil/Screens/Siparis/siparisler_yeni.dart';
import 'package:sdrmobil/Screens/Ziyaret/cari_hareket.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/controller/controller.dart';
import 'package:sdrmobil/controller/siparis_controller.dart';

class Siparisler extends StatelessWidget {
  const Siparisler({Key key }) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final SiparisController siparisController = Get.find();
    final Controller _controller = Get.find();

      
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,    
    ]);

    const List<Widget> widgetOptions = <Widget>[
      YeniSiparisler(),
      BekleyenSiparislerW(),
    ];

    

    return Obx(()=>
      WillPopScope(
      onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff009068),

            automaticallyImplyLeading: false,
            title: Container(          
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Icon(Icons.shopping_basket_outlined, color: Colors.white,
                    size: size.height * kRaporFiltereOran),

                  SizedBox(width: size.width * 0.03,),
                  Text('Siparişler', style: TextStyle(color: Colors.white ,fontSize: size.height * kRaporOranBaslik),),
                ],
              ),
            ),
            leading: IconButton(icon: Icon(Icons.arrow_back), color: Colors.white,  
              iconSize: size.height * kRaporFiltereOran,            
              onPressed:() async {            
                Navigator.of(context).pop();
                if (_controller.musteriKarti.value==1 || (_controller.musteriKarti.value==0 && _controller.uzaksiparis.value==0))
                {
                  Get.to(()=>CariHareket());
                }

                if (_controller.uzaksiparis.value==1)
                {
                                    
                  await siparisController.uzakSiparisZiyaretSonlandir(_controller.uzakIslemziyaretId.value);
                  
                  _controller.uzaksiparis.value=0;
                  _controller.musteriKarti.value=0;
                  _controller.uzakIslemziyaretId.value=0;
                  _controller.menuGoruntule.value=1;
                  
                  await _controller.getAktarilmamisZiyaret();                  
                  Get.to(()=>ProgramPage());
                }
              },
            ),            
            centerTitle: true,
          ),
          
          body: Center(
            child: widgetOptions.elementAt(siparisController.selectedIndex.value),
          ),

          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.blue,
            currentIndex: siparisController.selectedIndex.value,
            onTap: siparisController.onItemTapped,
            backgroundColor: Colors.white,
            iconSize: size.height * ksiparisoran4,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon:ImageIcon(                        
                  AssetImage("assets/icons/shield.ico"),                  
                ),                
                label: 'Yeni Siparişler',
              ),

              BottomNavigationBarItem(              
                icon: Icon(FontAwesome.hourglass_half),
                label: 'Bekleyen',            
              ),          
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton:Visibility(
            visible: siparisController.selectedIndex.value==0,
            
            child: Container(
              padding: EdgeInsets.only(right: size.width * 0.50),                      
              child:SiparisAnimatedButton(
                onPressed: () {},
                tooltip: 'Increment',
                icon: Icons.add,
              ),
            ),
          ),
           
        ),
      ),
    );
  }
}