
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sdrmobil/Screens/Raporlar/GunlukSiparisListesi/gunluk_siparis_listesi_baslik.dart';
import 'package:sdrmobil/Screens/Raporlar/GunlukSiparisListesi/gunluk_siparis_listesi_toplam.dart';
import 'package:sdrmobil/Screens/Raporlar/rapor_filtered.dart';
import 'package:sdrmobil/Screens/Raporlar/raporlar_ana_menu.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/controller/rapor_controller.dart';
import 'package:sdrmobil/models/Siparis/gunluk_siparis.dart';

import 'gunluk_siparis_listesi_card.dart';

class GunlukSiparisListesi extends StatelessWidget {
  const GunlukSiparisListesi({Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;    
    final RaporController _controller =Get.find();

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
          title: Text('Günlük Sipariş Raporu', style: TextStyle(color: Colors.white, fontSize: size.height * kRaporOranBaslik),),
          centerTitle: true,
          leading: IconButton(icon: Icon(Icons.arrow_back), color: Colors.white,
            iconSize: size.height * kRaporFiltereOran,
            onPressed:(){            
              Navigator.of(context).pop();            
              Get.to(()=>RaporlarAnaMenu());
            },
          ),

          actions: [
            IconButton(icon: Icon(Icons.filter_alt), color: Colors.white,
              iconSize: size.height * kRaporFiltereOran,
              onPressed:() async {

                await _controller.getDepoListesi();
                await _controller.getMalzemeGrupListesi();
                _controller.getRaporDegerleri();

                await Get.defaultDialog(
                  title: "",                
                  backgroundColor: Colors.white,
                  titleStyle: TextStyle(color: Colors.black),
                  middleTextStyle: TextStyle(color: Colors.black),                                
                  textConfirm: "Tamam",
                  textCancel: "İptal",
                  cancelTextColor: Colors.black,
                  confirmTextColor: Colors.black,
                  radius: 1,                
                  content: RaporFiltered(grupGoster: 1, gunlukSiparisR: 1),  
                  barrierDismissible: false,              
                  onConfirm: () async {
                    _controller.setDataDialog();                    
                    _controller.setRaporDegerleri();                    
                    Navigator.of(context).pop(false);
                  },
                  onCancel: () async {                  
                  }
                );
                
                //Get.to(()=> RaporlarAnaMenu());
              },
            ),
          ],

        ),
        
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: size.height * 0.085,
                child:GunlukSiparisListesiBaslik(),
              ),
            ),


            SliverFillRemaining(
              child: SizedBox(          
                height: size.height * 0.97,                  
                child: FutureBuilder<List<GunlukSiparis>>(              
                  future:_controller.sayac.value>0 ? _controller.getGunlukSiparis():_controller.getGunlukSiparis(),              
                  builder: (BuildContext context, AsyncSnapshot<List<GunlukSiparis>> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        semanticChildCount: snapshot.data.length,                      
                        itemBuilder: (context, index) {
                          GunlukSiparis item ;
                          item = snapshot.data[index];                          
                          return GunlukSiparisListesiCard(item: item, index: index);
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error');
                    } else {
                      //return Text('');
                      return Center(child:CircularProgressIndicator(color: Color(0xff009068),),);
                    }
                  },                
                ),
              ),
            ),  
            
          ],        
        ),

         bottomNavigationBar: Container(          
          height: size.height * 0.085,
          child:FutureBuilder<List<GunlukSiparisToplam>>(
            future: _controller.sayac.value>0 ? _controller.getGunlukSiparisToplam():_controller.getGunlukSiparisToplam(),
            builder: (BuildContext context, AsyncSnapshot<List<GunlukSiparisToplam>> snapshot) {
              if (snapshot.hasData) {
                  GunlukSiparisToplam item;
                  item=snapshot.data[0];
                  return GunlukSiparisToplamW(toplamMiktar: item.toplamMiktar==null ? 0 :item.toplamMiktar, 
                    toplamTutar: item.toplamTutar==null ? 0:item.toplamTutar,);

              }else if (snapshot.hasError) {
                return Text('Error');
              } else {
                return Center(child:CircularProgressIndicator(color: Color(0xff009068),),);
              }
            },
          ),
        ),


      ),
    ),
    );
  }
}