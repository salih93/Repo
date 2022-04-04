
import 'package:flutter/material.dart';
import 'package:sdrmobil/Screens/Login/components/menu_widget.dart';
import 'package:sdrmobil/Screens/Program/components/child_return.dart';
import 'package:sdrmobil/Screens/Program/components/get_label.dart';
import 'package:sdrmobil/Screens/Ziyaret/cari_hareket.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/controller/controller.dart';
import 'package:get/get.dart';
import 'package:sdrmobil/models/Satis/rut_listesi.dart';
import 'package:sdrmobil/providers/db_provider.dart';


class ProgramPage extends StatelessWidget {
   ProgramPage({Key key}):super(key: key);
  final Controller _controller =Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
    String firmaadi;
    String temsilciadi;
    String temsilcikodu;    

    firmaadi=_controller.firmaadi.value;
    temsilcikodu=_controller.temsilcikodu.value;
    temsilciadi = "Merkez Temsilci";
    

    var baseUrl=_controller.tanimList.firstWhere((element) => element.key=="android_resim_base_url").value.toString();
    var fotoPath=_controller.tanimList.firstWhere((element) => element.key=="temsilci_foto_path").value.toString();

    String imageUrl="";
    if (baseUrl!=null && fotoPath!=null)
    {
      imageUrl =baseUrl + "Temsilciler/" + fotoPath;
    }   


    return Obx(()=>Scaffold(      
        appBar: AppBar(                  
        backgroundColor: Color(0xff009068),
        title: !_controller.isSearching.value ? 
        Text(GetLabel().getText(_controller.menuGoruntule.value), style: TextStyle(color: Colors.white, 
          fontSize: size.height * kScreenOran)):
        TextField(
              onChanged: (value) {
                  _controller.isSearching.value = false;
                  _controller.carifilter.value=value;
                  _controller.isSearching.value = true;
                  _controller.update();                
              },

              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  hintText: "Ara...",
                  hintStyle: TextStyle(color: Colors.white)),
            ),
          

            actions:  <Widget>[                                    
              _controller.isSearching.value ? IconButton(
                icon: Icon(Icons.cancel),
                onPressed: () {                    
                  _controller.isSearching.value = true;
                  _controller.isSearching.value = false;
                  _controller.carifilter.value="";
                  _controller.update();
                  },
                ): 
                IconButton(
                  icon: _controller.menuGoruntule.value==1 ? Icon(Icons.search):Text(""),
                  onPressed: () {                      
                    _controller.isSearching.value = false;
                    _controller.isSearching.value = true;                      
                    _controller.update();  
                  },
                ),
              ]              
        ),
        drawer:  Menuwidget(imageUrl: imageUrl, firmaadi: firmaadi, temsilciadi: temsilciadi, temsilcikodu: temsilcikodu),

        body:(!_controller.isLoading.value) ? getChild():Center(child: CircularProgressIndicator(color: Color(0xff009068))),          
        
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton:
          Visibility(
            visible: (_controller.ziyaretId.value>0),
            child: Container(
            padding: EdgeInsets.only(left: size.width * 0.25),
            child: FloatingActionButton(
                onPressed: ()async {

                  RutListesi rutElement=await DBProvider.db.getRut(_controller.ziyaretId.value);
                  await _controller.getCurrentLocation();
                  
                  _controller.carikod.value=rutElement.kod.toString();
                  _controller.mesafe.value="";
                  _controller.rut.value=rutElement;
                  if (rutElement.enlem!=null && rutElement.enlem!="")
                    _controller.enlem.value=double.parse(rutElement.enlem);
                  else
                    _controller.enlem.value=0.0;
                    
                  if (rutElement.boylam!=null && rutElement.boylam!="")  
                    _controller.boylam.value=double.parse(rutElement.boylam);
                  else
                    _controller.boylam.value=0.0;
                  _controller.update();

                  //current position alınacak.
                  Navigator.of(context).pop();
                  Get.to(()=> CariHareket());

                  // if (await ZiyaretVeriIslemleri().ziyaretSonlandir()!=true)
                  // {      
                  //   return false;    
                  // }
                },

                backgroundColor: Colors.red,
                child: Icon(Icons.location_pin,),
              ),
            ),            
    
          ),

               
        bottomNavigationBar:Visibility(
          visible: _controller.menuGoruntule.value==5,
          child: Container(          
            height: 40,
            decoration: BoxDecoration(
            color: Color(0xff009068),
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(0),
                topRight: Radius.circular(0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Wrap(
                  children: [
                    Text("Versiyon: ", 
                      style:TextStyle(fontSize: size.height * kaktarimbasoran, color: Colors.white),),

                    Text(kUygulamaVersiyonu, 
                      style:TextStyle(fontSize: size.height * kaktarimbasoran, color: Colors.white),),
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



