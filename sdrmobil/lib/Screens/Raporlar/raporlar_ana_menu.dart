
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:sdrmobil/Screens/Program/program.dart';
import 'package:sdrmobil/Screens/Raporlar/AcikHesapListesi/acik_hesap_listesi.dart';
import 'package:sdrmobil/Screens/Raporlar/BekleyenSiparis/bekleyen_siparis_raporu.dart';
import 'package:sdrmobil/Screens/Raporlar/GrupBazindaSatislar/grup_bazinda_satislar_aylik.dart';
import 'package:sdrmobil/Screens/Raporlar/GunlukSiparisListesi/gunluk_siparis_listesi.dart';
import 'package:sdrmobil/Screens/Raporlar/MusteriMalAnaliziAy/musteri_mal_analizi_ay.dart';
import 'package:sdrmobil/Screens/Raporlar/GrupBazindaSatislar/grup_bazinda_satistar.dart';
import 'package:sdrmobil/Screens/Raporlar/MusteriMalAnalizi/musteri_mal_analizi.dart';
import 'package:sdrmobil/Screens/Raporlar/GunlukTahsilatListesi/gunluk_tahsilat_listesi.dart';
import 'package:sdrmobil/Screens/Raporlar/raporlar_ana_menu_card.dart';
import 'package:sdrmobil/Screens/Raporlar/StokFiyatListesi/stok_fiyat_listesi.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/controller/controller.dart';
import 'package:sdrmobil/controller/rapor_controller.dart';
import 'package:typicons_flutter/typicons_flutter.dart';


class RaporlarAnaMenu extends StatelessWidget {
  
  const RaporlarAnaMenu({Key key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final RaporController _controller =Get.put(RaporController());
    final Controller _mainController = Get.find();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff009068),          
        title: Text("Raporlar", style: TextStyle(fontSize: size.height * kRaporOranBaslik)),
        leading: IconButton(icon: Icon(Icons.arrow_back), color: Colors.white,
          iconSize: size.height * kRaporFiltereOran,
          onPressed:() {
            Navigator.of(context).pop();
            _mainController.menuGoruntule.value=0;               
            _mainController.update();
            _controller.bekleyenSiparisMalzemeGrup.clear();            
            Get.to(()=> ProgramPage());
          },
        ),

        actions: [
          Row(              
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Padding(padding:EdgeInsets.only(right: 10) ,child: Image.asset(
                  'assets/images/sdr-upbar-logo-icon.png',
                  fit: BoxFit.contain,
                  height: 40,
                  
                ),
                ),
              ],
            ),
          ],
      ),

      body:SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RaporlarAnaMenuCard(size: size, 
              butonText: "Stok Fiyat Listesi",
              icon: Icon(Typicons.chart_bar, color: Colors.white,),
              color: Colors.white,
              onPressed: (){
                _controller.setData();
                _controller.setMalzemeGrup();
                Get.to(()=>StokFiyatListesi());
              },
            ),

            RaporlarAnaMenuCard(size: size, 
              butonText: "Müşteri Mal Analizi",
              icon: Icon(FlutterIcons.chart_arc_mco, color: Colors.blue[900]),
              color: Colors.blue,
              onPressed: () async {
                _controller.setData();
                _controller.setMalzemeGrup();

                await _controller.getMMAnaliziMusCount();
                //Navigator.of(context).pop();
                Get.to(()=>MusteriMalAnaliziW());
              },
            ),

            RaporlarAnaMenuCard(size: size, 
              butonText: "Müşteri Mal Analizi Ay Bazında Miktar Tutar",
              icon: Icon(FlutterIcons.chart_areaspline_mco, color: Colors.white,),
              color: Colors.white,
              onPressed: () async {
                _controller.setData();
                _controller.setMalzemeGrup();
                //await _controller.getMMAnaliziMusCount();
                Get.to(()=>MusteriMalAnaliziAyW());
              },
            ),


            RaporlarAnaMenuCard(size: size, 
              butonText: "Grup Bazında Satışlar",
              icon: Icon(FlutterIcons.chart_bar_faw5s,color: Colors.blue[900], ),           
              color: Colors.blue,
              onPressed: () async {
                _controller.setData();
                _controller.setMalzemeGrup();
                await _controller.getMMAnaliziMusCount();              
                Get.to(()=>GrupBazindaSatislar());
              },
            ),

            RaporlarAnaMenuCard(size: size, 
              butonText: "Grup Bazında Satışlar Aylık Miktar Tutar",
              icon: Icon(FlutterIcons.chart_histogram_mco,color: Colors.black,),            
              color: Colors.white,
              //reverse: 1,
              onPressed: () async {
                _controller.setData();
                _controller.setMalzemeGrup();
                // getMusteriMalAnaliziAylikGruplu
                
                 Get.to(()=>GrupBazindaSatislarAylik());
              },
            ),

            RaporlarAnaMenuCard(size: size, 
              butonText: "Açık Hesap Listesi",
              icon: Icon(FontAwesome.pie_chart,color: Colors.blue[900],),
              //reverse: 1,
              color: Colors.blue,
              onPressed: () async {
                _controller.setData();
                _controller.setMalzemeGrup();              
                Get.to(()=>AcikHesapListesiW());
              },
            ),

            RaporlarAnaMenuCard(size: size, 
              butonText: "Günlük Tahsilat Raporu",
              icon: Icon(FlutterIcons.line_chart_faw,color: Colors.white,),
              //reverse: 1,
              color: Colors.white,
              onPressed: () async {
                _controller.setData();
                await _controller.getGunlukTahsilatToplam();
                _controller.setMalzemeGrup();
                Get.to(()=>GunlukTahsilatListesi());
              },
            ),

            RaporlarAnaMenuCard(size: size, 
              butonText: "Bekleyen Sipariş Raporu",
              icon: Icon(FlutterIcons.chart_bubble_mco, color: Colors.blue[900],),
              //reverse: 1,
              color: Colors.blue,
              onPressed: () async {
                _controller.setData();
                _controller.setMalzemeGrup();              
                Get.to(()=>BekleyenSiparisRaporu());
              },
            ),
                        

            RaporlarAnaMenuCard(size: size, 
              butonText: "Günlük Sipariş Raporu",
              //icon: new Image.asset('assets/icons/line-chart.png'),
              icon:Icon(FlutterIcons.area_graph_ent, color: Colors.white,),
              color: Colors.blue, 
              onPressed: () async {
                _controller.setData();
                _controller.setMalzemeGrup();              
                Get.to(()=>GunlukSiparisListesi());
              },
            ),


          ],

        ),
      ),
    );

  }
}



