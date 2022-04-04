import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sdrmobil/Screens/Login/components/background.dart';
import 'package:sdrmobil/Screens/Program/program.dart';
import 'package:sdrmobil/Screens/Raporlar/ZiyaretRaporlari/cari_hesap_ekstresi_list.dart';
import 'package:sdrmobil/Screens/Raporlar/ZiyaretRaporlari/cari_satislar.dart';
import 'package:sdrmobil/Screens/Siparis/siparisler.dart';
import 'package:sdrmobil/Screens/Tahsilat/tahsilat_ana_sayfa.dart';
import 'package:sdrmobil/Screens/Ziyaret/ziyaret_card.dart';
import 'package:sdrmobil/Screens/Ziyaret/ziyaret_sonlandirma.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/controller/controller.dart';
import 'package:sdrmobil/controller/siparis_controller.dart';
import 'package:sdrmobil/controller/tahsilat_controller.dart';
//maca yansıt
class CariHareket extends StatelessWidget {
  const CariHareket({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Controller _controller = Get.find();
    final SiparisController scontroller=Get.find();
    final TahsilatController tcontroller=Get.find();
    Size size = MediaQuery.of(context).size;
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,    
    ]);

    return Obx(()=>WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Color(0xff009068),          
            title: Text(DateFormat('dd-MM-yyyy').format(DateTime.now()),style: TextStyle(fontSize: size.height * kRaporOranBaslik)),

            leading:IconButton(icon: Icon(Icons.arrow_back), color: Colors.white,
              iconSize: size.height * kRaporFiltereOran,
              onPressed:() async {
                if (_controller.musteriKarti.value==1)
                {
                  await scontroller.uzakSiparisZiyaretSonlandir(_controller.uzakIslemziyaretId.value);
                }

                _controller.uzaksiparis.value=0;
                _controller.musteriKarti.value=0;
                _controller.uzakIslemziyaretId.value=0;
                _controller.menuGoruntule.value=1;                  
                _controller.update();
                Navigator.of(context).pop();
                
                await _controller.getAktarilmamisZiyaret();
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
                      //height: size.height * 0.2,
                      height: size.height * kRaporFiltereOran,

                    ),
                   ),
                  ],
                ),
              ],
            ),
            body:Background(            
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.only(top: 5),
                    child: Card(                                        
                      child:
                        ListTile(
                          title: Container(child: Row(
                            children: [
                              Expanded(flex: 4,
                                child: Column(
                                  mainAxisAlignment:MainAxisAlignment.center ,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [                                  
                                     Container(
                                      decoration:BoxDecoration(
                                        shape: BoxShape.circle,                                      
                                      ) ,
                                      child: Image.asset('assets/icons/shop.png',
                                      fit: BoxFit.contain),
                                    ),                                  
                                  ],
                                ),
                              ),
                       

                              Expanded(flex: 9,
                              child: Column(
                                mainAxisAlignment:MainAxisAlignment.center ,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                    Center(child:Text(_controller.temsilciadi.value, 
                                      style: TextStyle(fontSize: size.height * kcarihareketoran),),),
                                    ],
                                  ),

                                  SizedBox(height: size.height * 0.01),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            FittedBox(
                                              fit: BoxFit.none,
                                              child: Text(_controller.rut.value.unvan.toString(), 
                                              style: TextStyle(fontSize: size.height * kcarihareketoran, color: Colors.blue),),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: size.height * 0.01),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [                                  
                                      Center(
                                        child:Text("", 
                                        style: TextStyle(fontSize: 10, backgroundColor: Color(0xff009068),
                                              color: Colors.white),
                                            ),
                                      ),
                                    ],                                  
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Padding(padding: EdgeInsets.only(right: 5),
                                      child: Text("Giriş: " + DateFormat.Hm().format(DateTime.now()).toString(),
                                              style: TextStyle(fontSize: size.height * kcarihareketoran3),textAlign:TextAlign.end,),      
                                      ),
                                    ],

                                  ),
                                ],                            
                              ),
                            ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [                              
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                    
                                    ),
                                  ],
                                ),
                              ),

                            ],
                          ),
                      ),
                        ),                  
                    ),
                  ),                

                  (_controller.musteriKarti.value==0 || _controller.telefonSiparis.value==1) ?
                  MyZiyaretCard(textField: "Siparişler",
                      textColor: Colors.black,
                      icons: Icon(Icons.shopping_cart_outlined, size: size.height * kcarihareketoran1,color: Colors.green,),                    
                      onClick: ()async {
                        //Navigator.of(context).pop();
                        await scontroller.bekleyenSiparisGruplu();
                        Get.to(()=>Siparisler());
                      },
                  ):SizedBox(height: size.height * 0.005,),
                                    
                  
                  (_controller.musteriKarti.value==0 && _controller.nakittahsilatkullansin.value==1) ? 
                  MyZiyaretCard(textField: "Tahsilatlar",
                        textColor: Colors.black,
                        icons:ImageIcon(                        
                        AssetImage("assets/icons/tahsilat.png"),
                        color: Colors.green,
                        size: size.height * kcarihareketoran0,                      
                      ),
                      onClick: (){
                        //Navigator.of(context).pop();
                        Get.to(()=>TahsilatAnaSayfa());
                      },
                  ):SizedBox(height: size.height * 0.005,),

                  MyZiyaretCard(textField: "Cari Hesap Ekstresi",
                      textColor: Colors.black,
                      icons: Icon(Icons.format_align_justify, size: size.height * kcarihareketoran0, color:Colors.green,),                    
                      onClick: (){
                        //Navigator.of(context).pop();
                        Get.to(()=>CariHesapEkstresiList());
                      },
                  ),

                  MyZiyaretCard(textField: "Satışlar",
                      textColor: Colors.black,
                      icons: Icon(Icons.wb_sunny_outlined, size: size.height * kcarihareketoran0,color:Colors.green,),
                      onClick: (){
                        _controller.isSearching.value=false;
                        //Navigator.of(context).pop();                      
                         Get.to(()=>CariSatislarW());
                      },
                  ),                
                ],
              ),

            ),

            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton:
            Opacity(
              opacity: (_controller.ziyaretId.value>0 && _controller.uzaksiparis.value==0 ) ? 1 : 0,
              child: FloatingActionButton.extended(
                  onPressed: ()async {
                    
                    tcontroller.ziyaretSonlandirmaTipiSayac.value=0;
                    tcontroller.ziyaretSonlandirmaTipi.text="";
                    tcontroller.aciklamaZController.text="";
                    tcontroller.zorunluaciklama.value=0;
                    await tcontroller.getSiparisTahsilatKontrol();
                    
                    Navigator.of(context).pop();
                    Get.to(()=>ZiyaretSonlandirma());
                  },

                  backgroundColor: Colors.red,
                  label: Text("Ziyareti Sonlandır"),
                  icon: Icon(Icons.location_off_sharp,),

                ),
              //),            
      
            ),
        ),
    ),
    );
  }
}

