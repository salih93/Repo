import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sdrmobil/Screens/Login/components/background.dart';
import 'package:sdrmobil/Screens/Map/map_screen.dart';
import 'package:sdrmobil/Screens/Program/program.dart';
import 'package:sdrmobil/Screens/Tahsilat/row_input_card.dart';
import 'package:sdrmobil/Screens/Ziyaret/cari_hareket.dart';
import 'package:sdrmobil/VeritabaniIslemleri/ziyaret_veri_islemleri.dart';
import 'package:sdrmobil/components/get_snackbar.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/controller/controller.dart';
import 'package:sdrmobil/controller/tahsilat_controller.dart';

class ZiyaretSonlandirma extends StatelessWidget {
  const ZiyaretSonlandirma({Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final Controller mainController = Get.find();
    final TahsilatController _controller = Get.find();
    
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,    
    ]);


    return Obx(()=> WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(size.height * 0.06),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Color(0xff009068),
            title: Text('Ziyaret Sonlandırma', style: TextStyle(color: Colors.white, fontSize: size.height * kRaporOranBaslik),),
            leading: IconButton(icon: Icon(Icons.arrow_back), color: Colors.white,
              iconSize: size.height * kRaporFiltereOran,
              onPressed:(){            
                Navigator.of(context).pop();            
                Get.to(()=>CariHareket());
              },
            ),
  
            actions: [                    
              Padding(
                padding: EdgeInsets.only(bottom:size.height * 0.005, top: size.height * 0.001),
                child: TextButton(                              
                  style: ButtonStyle(                  
                    fixedSize: MaterialStateProperty.all(Size(size.width * 0.18, size.height * 0.01)),

                    backgroundColor: MaterialStateProperty.all(Color(0xff009068)), 
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        side: BorderSide(color: Colors.white)
                      ),
                    ),
                  ),
                  child: Text("Devam", style: TextStyle(color: Colors.white, fontSize: size.height * kziyaretsonoran,),),
                  onPressed: () async {
                      print('Ziyareti Sonlandır');
                    
                    if (_controller.zorunluaciklama.value==1)
                    {
                       if (_controller.aciklamaZController.text == "" || _controller.aciklamaZController.text == null) {                          
                          snackbar("Uyarı", "Açıklama girmelisiniz!", Icons.error_outline);
                          return false;                          
                        }
                    }                   

                    if (await ZiyaretVeriIslemleri().ziyaretSonlandir()!=true)
                    {      
                      return false;    
                    }
                    _controller.zorunluaciklama.value=0;                  
                    mainController.menuGoruntule.value=0;
                    Navigator.of(context).pop();
                    
                    await mainController.getAktarilmamisZiyaret();
                    Get.to(()=>ProgramPage());
                  },

                ),
              ),        
            ],
          ),
        ),

        body: Background(
          child:Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(child: 
                ListTile( 
                  contentPadding: EdgeInsets.only(left: size.width * kziyaretsonoran, right: size.width * kziyaretsonoran),
                  title: Row(
                  children: [                    
                    Expanded(flex: 3,child:Column( 
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,                     
                        children: [
                          Padding(padding: EdgeInsets.only(top: 5),
                            child: Text('Sebep:', style:TextStyle(fontSize: size.height * kziyaretsonoran),),
                          ),                        
                        ],
                      ),
                    ),

                    Expanded(flex: 4,child: Column(                        
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DropdownButtonHideUnderline(                            
                            child: DropdownButton( 
                              style: TextStyle(fontSize: size.height * kziyaretsonoran, color: Colors.black),                               
                              autofocus: false,
                              hint:new Text(_controller.ziyaretSonlandirmaTipi.text),
                              value: _controller.ziyaretSonlandirmaTipi.text,
                              onChanged: (newValue) async {
                                _controller.ziyaretSonlandirmaTipi.text=newValue;
                                _controller.ziyaretSonlandirmaTipiSayac.value=
                                  await _controller.getZiyaretSonlandirmaTipiSayac(newValue.toString());
                                _controller.update();                                  
                              },
                              items: _controller.getZiyaretDropDownMenu().toList(),
                            ),
                          ),
                        ]                      
                      ),
                    ),                      
                    ],
                  ),
                ),               
              ),
              

              RowInputCard(
                controller: _controller.aciklamaZController,
                hintText: "Açıklama girin",
                inputText: 'Açıklama: ',
                onChanged: (value){},
                textType: TextInputType.multiline,                  
                autoFocus: false,
                readOnly: false,
                fontoran: kziyaretsonoran,
              ),

              _controller.ziyaretSonlandirmaTipiSayac.value>0 ? 
                SizedBox(height: size.height * 0.01):SizedBox(height: size.height * 0.01),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      height: size.height * 0.65,
                      width: size.width * 0.938,
                      child: MapScreen(onlyLocation: 1,),
                    ),
                  ),              
                ],
              ),

            ],

          ),
        ),
        
              
      ), 
    ),
 
    );

  }
}