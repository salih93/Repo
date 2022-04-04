import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sdrmobil/Screens/Login/components/background.dart';
import 'package:sdrmobil/Screens/Raporlar/rapor_filtered.dart';
import 'package:sdrmobil/Screens/Raporlar/raporlar_ana_menu.dart';
import 'package:sdrmobil/Screens/Raporlar/StokFiyatListesi/stok_fiyat_listesi_card.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/controller/rapor_controller.dart';
import 'package:sdrmobil/models/Malzeme/malzeme_fiyat.dart';
import 'package:sdrmobil/models/Siparis/bekleyen_siparis_gruplu.dart';

class StokFiyatListesi extends StatelessWidget {
  const StokFiyatListesi({Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;    
    final RaporController rcontroller =Get.find();

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
        title: Text('Stok Fiyat Listesi', style: TextStyle(color: Colors.white, fontSize: size.height * kRaporOranBaslik),),
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.arrow_back), color: Colors.white,
          iconSize: size.height * kRaporFiltereOran,
          onPressed:(){
            Navigator.of(context).pop();
            Get.to(()=> RaporlarAnaMenu());
          },
           //constraints: BoxConstraints(maxHeight: 40),
        ),
//
         actions: [
            IconButton(icon: Icon(Icons.filter_alt), color: Colors.white,
              constraints: BoxConstraints(maxHeight: 44),
              iconSize: size.height * kRaporFiltereOran,

              onPressed:() async {
                rcontroller.setMalzemeGrup();
                await rcontroller.getMalzemeGrupListesi();                
                rcontroller.getRaporDegerleri();

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
                  content: RaporFiltered(grupGoster: 2, gunlukSiparisR: 3),
                  barrierDismissible: false,
                  onConfirm: () async {
                    rcontroller.setDataDialog();
                    rcontroller.setRaporDegerleri();                    
                    Navigator.of(context).pop();
                  },

                  onCancel: () async {                  
                  }

                );
                //Get.to(()=> RaporlarAnaMenu());
              },
            ),
          ],

        
      ),

      body: Background(      
          child: Container(          
            padding: EdgeInsets.only(top: size.height * 0.01),
            child: FutureBuilder<List<MalzemeFiyat>>(              
              future:rcontroller.sayac.value>0 ? rcontroller.getStokFiyatListesi():rcontroller.getStokFiyatListesi(),             
              builder: (BuildContext context, AsyncSnapshot<List<MalzemeFiyat>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      MalzemeFiyat malzemeFiyat;
                      malzemeFiyat = snapshot.data[index];

                      BekleyenSiparisGruplu bitem=new BekleyenSiparisGruplu(malzemekodu: malzemeFiyat.malzemekodu,
                        miktar: 0, bazbirim: malzemeFiyat.bazbirim, birimi: malzemeFiyat.bazbirim);

                      if (rcontroller.bekleyenSiparisMalzemeGrup.where((item) => item.malzemekodu==malzemeFiyat.malzemekodu).length>0)
                        bitem=rcontroller.bekleyenSiparisMalzemeGrup.firstWhere((item) => item.malzemekodu==malzemeFiyat.malzemekodu);
                        
                      return StokFiyatListesiCard(item: malzemeFiyat, index: index,bItem: bitem,);
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
    ),
    ),
    );

  
  }
}
