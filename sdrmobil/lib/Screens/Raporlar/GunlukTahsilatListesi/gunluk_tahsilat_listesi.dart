
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sdrmobil/Screens/Raporlar/GunlukTahsilatListesi/gunluk_tahsilat_listesi_card.dart';
import 'package:sdrmobil/Screens/Raporlar/rapor_filtered.dart';
import 'package:sdrmobil/Screens/Raporlar/raporlar_ana_menu.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/controller/rapor_controller.dart';
import 'package:sdrmobil/models/Raporlar/gunluk_tahsilat.dart';
import 'package:sdrmobil/models/Raporlar/musteri_toplamlari.dart';

class GunlukTahsilatListesi extends StatelessWidget {
  const GunlukTahsilatListesi({Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;    
    final RaporController _controller =Get.find();
    List<MusteriToplamlari> toplamlar=<MusteriToplamlari>[];
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,    
    ]);

    int toplamYaz=0;  

    return Obx(()=>WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xff009068),
          title: Text('Günlük Tahsilat Raporu', style: TextStyle(color: Colors.white, fontSize: size.height * kRaporOranBaslik),),
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

                await _controller.getRutCariListesi();
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
                  barrierDismissible: false,
                  radius: 1,                
                  content: RaporFiltered(grupGoster: 0, gunlukSiparisR: 0),                
                  onConfirm: () async {
                    _controller.setDataDialog();
                    toplamlar.clear();
                    _controller.setRaporDegerleri();
                    await _controller.getGunlukTahsilatToplam();                  
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
            SliverFillRemaining(
              child: SizedBox(          
                height: size.height * 0.97,                  
                child: FutureBuilder<List<GunlukTahsilat>>(              
                  future:_controller.sayac.value>0 ? _controller.getGunlukTahsilat():_controller.getGunlukTahsilat(),              
                  builder: (BuildContext context, AsyncSnapshot<List<GunlukTahsilat>> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        semanticChildCount: snapshot.data.length,                      
                        itemBuilder: (context, index) {
                          GunlukTahsilat item ;
                          item = snapshot.data[index];
                          toplamYaz=0;
                          if (snapshot.data.length-1==index) toplamYaz=1;

                          return GunlukTahsilatListesiCard(item: item, index: index, toplamYaz: toplamYaz,);

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

        //bottomNavigationBar: 

      ),
    ),
    );
  }
}