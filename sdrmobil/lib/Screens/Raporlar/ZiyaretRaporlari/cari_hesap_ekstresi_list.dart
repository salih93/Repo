import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:sdrmobil/Screens/Raporlar/ZiyaretRaporlari/cari_hesap_ekstresi_list_card.dart';
import 'package:sdrmobil/Screens/Raporlar/ZiyaretRaporlari/cari_hesap_ekstresi_list_toplam.dart';
import 'package:sdrmobil/Screens/Ziyaret/cari_hareket.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/controller/controller.dart';
import 'package:sdrmobil/models/Cari/cari_hesap_ekstresi.dart';
import 'package:sdrmobil/models/Cari/cari_hesap_ekstresi_toplam.dart';

class CariHesapEkstresiList extends StatelessWidget {
  CariHesapEkstresiList({Key key }) : super(key: key);
  
  
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
  

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(      
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xff009068),          
          title: Text('Cari Hesap Ekstresi', style: TextStyle(fontSize: size.height * kRaporOranBaslik),),
          actions: [
            Row(              
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  Padding(padding:EdgeInsets.only(right: 10) ,child: Image.asset(
                    'assets/images/sdr-upbar-logo-icon.png',
                    fit: BoxFit.contain,
                    height: size.height * 0.05,
                  ),
                ),
              ],
            ),
          ],
          leading: IconButton(icon: Icon(Icons.arrow_back), color: Colors.white,
            iconSize: size.height * kRaporFiltereOran,
            onPressed:(){            
              Navigator.of(context).pop();            
              Get.to(()=>CariHareket());
            },
          ),
        ),

        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(          
                  height: size.height * 0.085,
                  child:FutureBuilder<List<CariHesapEkstresiToplam>>(
                    future: _controller.getCariHesapEkstresiToplam(),
                    builder: (BuildContext context, AsyncSnapshot<List<CariHesapEkstresiToplam>> snapshot) {
                      if (snapshot.hasData) {
                          CariHesapEkstresiToplam ekstreToplam;
                          ekstreToplam=snapshot.data[0];
                          return 
                          CariHesapEkstresiListToplam(toplamBorc:ekstreToplam.toplamBorc==null ? 0.0:ekstreToplam.toplamBorc, 
                                          toplamAlacak:ekstreToplam.toplamAlacak==null ? 0.0:ekstreToplam.toplamAlacak);

                      }else if (snapshot.hasError) {
                        return Text('Error');
                      } else {
                        return Center(child:CircularProgressIndicator(color: Color(0xff009068),),);
                      }
                    },
                  ),
                ),
            ),
            
            SliverFillRemaining(              
              child: SizedBox(
                height: size.height * 0.85,                
                child: FutureBuilder<List<CariHesapEkstresi>>(
                  future: _controller.getCariHesapEkstresi(),
                  builder: (BuildContext context, AsyncSnapshot<List<CariHesapEkstresi>> snapshot) 
                  {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          CariHesapEkstresi ekstreT;                  
                          ekstreT = snapshot.data[index];
                          return CariHesapEkstreCard(ekstre: ekstreT,);
                        },                
                      );
                    } 
                    else if (snapshot.hasError) {
                      return Text('Error');
                      } 
                      else {
                        return Center(child:CircularProgressIndicator(color: Color(0xff009068),),);
                      }
                  },
                ),
              ),
            ),
                
          ],  

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
    );
        
      
     
    
  }  
}




  