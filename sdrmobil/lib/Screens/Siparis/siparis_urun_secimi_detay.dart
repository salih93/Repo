
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sdrmobil/Screens/Login/components/background.dart';
import 'package:sdrmobil/Screens/Siparis/Component/siparis_urun_secimi_detay_container.dart';
import 'package:sdrmobil/Screens/Siparis/Component/siparis_urun_secimi_detay_row1.dart';
import 'package:sdrmobil/Screens/Siparis/Component/siparis_urun_secimi_detay_row2.dart';
import 'package:sdrmobil/Screens/Siparis/Component/siparis_urun_secimi_detay_row3.dart';
import 'package:sdrmobil/Screens/Siparis/siparis_girisi_urun.dart';
import 'package:sdrmobil/VeritabaniIslemleri/siparis_veri_islemleri.dart';
import 'package:sdrmobil/components/get_snackbar.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/controller/controller.dart';
import 'package:sdrmobil/controller/siparis_controller.dart';
class SiparisUrunSecimiDetay extends StatelessWidget { 

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,    
    ]);

    final SiparisController _controller =Get.find();
    final Controller anaController = Get.find();
    
    Locale myLocale = Localizations.localeOf(context);    
    var decimal=_controller.getDecimalSeparator(myLocale.languageCode);

    
    return Obx(()=>WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xff009068),
          title: Text('Miktar Detay', style: TextStyle(color: Colors.white, fontSize: size.height * kRaporOranBaslik),),
          leading: IconButton(icon: Icon(Icons.arrow_back), color: Colors.white,
            iconSize: size.height * kRaporFiltereOran,
            onPressed:(){
              _controller.isSearching.value=false;
              _controller.searchController.text="";
                            
              Navigator.of(context).pop();
              Get.to(()=> SiparisGirisiUrun()); 
            },
          ),
          
          actions: [                    
            SizedBox(
              height: size.height * 0.06,
              width: size.width * 0.22,

              child: Padding(
                padding: EdgeInsets.only(bottom:size.height * 0.005, top: size.height * 0.001),
                child: TextButton(                  
                  style: ButtonStyle(                  
                    fixedSize: MaterialStateProperty.all(Size(size.width * 0.18, size.height * 0.01)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: BorderSide(color: Colors.white)                        
                      ),
                    ),
                    
                  ),

                  onPressed: () async {
                      print('Kaydet ');                      
                      bool kaydet=await SiparisVeriIslemleri().siparisKaydet(context);
                      if (kaydet)
                      {
                        anaController.startProgress();
                        _controller.siparissatirrsayac.value=0;
                        await _controller.getSiparisListCount(0);

                        _controller.isSearching.value=true;
                        _controller.isSearching.value=false;
                        _controller.searchController.text="";
                        _controller.siparissatirrsayac.value=0;
                        _controller.sepetiac.value=0;
                        try {
                          await _controller.malzemeDoldur(1);  
                        } catch (e) {
                          print(e.toString());
                          snackbar("Hata",'Malzeme Listesi Alınamadı.' + e.toString().substring(0,100), Icons.error);
                          anaController.startProgress();
                        }
                        anaController.startProgress();
                        Navigator.of(context).pop();
                        Get.to(()=>SiparisGirisiUrun());
                        
                      }
                  },

                  child: Text("Kaydet", style: TextStyle(color: Colors.white, fontSize: size.height * ksiparisoran,),
                    ),
                  ),
              ),
            ),        
          ],
        ),

        body:  Background(
          child: Column(
            children: [
              Container(
                height: size.height * 0.32,
                child: Card(
                  shadowColor: Colors.blue[100],
                  elevation: 6.0,
                  child: ListTile(
                    contentPadding: EdgeInsets.only(left: 5),
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: size.height * 0.01,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  AutoSizeText(
                                    _controller.secilenUrun.malzemeadi, 
                                    style: TextStyle(fontSize: size.height * ksiparisoran, color: Colors.blue[800]),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ],
                              ),
                            ), 
                          ],
                        ),

                        SizedBox(height: size.height * 0.01,),
                        Row(
                          children: [
                            Wrap(
                              children: [
                                Text('Ürün Kodu : ', style: TextStyle(fontSize: size.height * ksiparisoran)),
                                Text(_controller.secilenUrun.malzemekodu, style: TextStyle(color: Colors.blue[800], fontSize: size.height * ksiparisoran)),
                              ],
                            ),
                          ],
                        ),

                        SizedBox(height: size.height * 0.03,),
                        _controller.isSearching.value==true ? SiparisUrunSecimiDetayRow1():SiparisUrunSecimiDetayRow1(),

                        SizedBox(height: size.height * 0.02,),
                        SiparisUrunSecimiDetayRow2(),
                        
                        SizedBox(height: size.height * 0.02,),
                        SiparisUrunSecimiDetayRow3(),

                      ],

                    ),
                  ),
                ),
              ),        

              SiparisUrunSecimiDetayContainer(size: size, controller: _controller, anaController: anaController, decimal: decimal),
              ],
            ),
          ),      
        ),
    ),
    );

  }
}






