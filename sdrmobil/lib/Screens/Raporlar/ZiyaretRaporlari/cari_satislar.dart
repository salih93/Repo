
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sdrmobil/Screens/Raporlar/ZiyaretRaporlari/cari_satislar_aylik.dart';
import 'package:sdrmobil/Screens/Raporlar/ZiyaretRaporlari/cari_satislar_card.dart';
import 'package:sdrmobil/Screens/Ziyaret/cari_hareket.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/controller/controller.dart';
import 'package:sdrmobil/models/Satis/aylik_satis.dart';

class CariSatislarW extends StatelessWidget {
  CariSatislarW({Key key }) : super(key: key);
  
  
  @override
  Widget build(BuildContext context) {
    final Controller _controller = Get.find();   
    Locale myLocale = Localizations.localeOf(context);
    initializeDateFormatting(myLocale.languageCode);
    Size size = MediaQuery.of(context).size;
        
    //Size size = MediaQuery.of(context).size;  
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    
    return Obx(()=> WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(        
        appBar: AppBar(
          automaticallyImplyLeading: false,
            backgroundColor: Color(0xff009068),
            title: !_controller.isSearchingSatis.value ? Text('Satışlar', style:TextStyle(fontSize: size.height * kRaporOranBaslik),):TextField(
                  onChanged: (value) {                
                    _controller.searchValueSatis.value=value;
                    _controller.isSearchingSatis.value = true;
                    _controller.update();                 
                  },
                  style: TextStyle(color: Colors.white, fontSize: size.height * kRaporOranBaslik),
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: size.height * kRaporFiltereOran,
                      ),
                      hintText: "Ara...",
                      hintStyle: TextStyle(color: Colors.white)),
                ),            

            //Text(DateFormat.yMd('tr_TR').format(DateTime.now()),),
            actions: [            
              _controller.isSearchingSatis.value ? IconButton(
                icon: Icon(Icons.cancel),
                iconSize: size.height * kRaporFiltereOran,
                onPressed: () {                    
                      _controller.isSearchingSatis.value = false;
                      _controller.searchValueSatis.value="";
                      _controller.update();
                  },
                ) : 
                IconButton(
                  icon: Icon(Icons.search),
                  iconSize: size.height * kRaporFiltereOran,
                  onPressed: () {                      
                      _controller.isSearchingSatis.value = true;
                      _controller.update();  
                  },
                ),
                
              ],
            leading:IconButton(icon: Icon(Icons.arrow_back), color: Colors.white,
              iconSize: size.height * kRaporFiltereOran,
              onPressed:(){                
                Navigator.of(context).pop();
                Get.to(()=>CariHareket());
              },
            ),

          ),

          body: FutureBuilder<List<CariAylikSatis>>(
              future: (_controller.isSearchingSatis.value==true && _controller.searchValueSatis.value!="" ) ? 
              _controller.getfilterSatislar():_controller.getCariSatislar(),
              builder: (BuildContext context, AsyncSnapshot<List<CariAylikSatis>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    CariAylikSatis ekstreT;                  
                    ekstreT = snapshot.data[index];

                    return CariSatislarCard(ekstre: 
                      ekstreT,onTap_:()
                      {                        
                        Get.to(()=>CariSatislarAylikW(ekstre:ekstreT));
                      }

                    );
                  },                
                );

                } else if (snapshot.hasError) {
                  return Text('Error');
                } else {
                  return Center(child:CircularProgressIndicator(color: Color(0xff009068),),);
                }
              },
            ),            
            
            floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
            floatingActionButton: Visibility(
              visible: (_controller.ziyaretId.value>0 && _controller.musteriKarti.value!=1 ),
              child: Container(
              padding: EdgeInsets.only(left: size.width * 0.25),
              child: FloatingActionButton(
                  onPressed: ()async {
                    Navigator.of(context).pop();            
                    Get.to(()=>CariHareket());
                  },
                  backgroundColor: Colors.red,
                  child: Icon(Icons.location_pin,),
                ),
              ),
            ),


        ),
    ),
    );
  }  
}