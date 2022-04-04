import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:sdrmobil/Screens/Raporlar/MusteriMalAnalizi/musteri_mal_analizi_baslik.dart';
import 'package:sdrmobil/Screens/Raporlar/MusteriMalAnalizi/musteri_mal_analizi_card.dart';
import 'package:sdrmobil/Screens/Raporlar/MusteriMalAnalizi/musteri_mal_analizi_toplam.dart';
import 'package:sdrmobil/Screens/Raporlar/rapor_filtered.dart';
import 'package:sdrmobil/Screens/Raporlar/raporlar_ana_menu.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/controller/rapor_controller.dart';
import 'package:sdrmobil/models/Raporlar/musteri_mal_analizi_mlzmus_toplam.dart';
import 'package:sdrmobil/models/Raporlar/musteri_toplamlari.dart';

class MusteriMalzemeToplamlari{
  String carikodu;
  String malzemeKodu;
  MusteriMalzemeToplamlari({
    this.carikodu,
    this.malzemeKodu
  });
}
//
class MusteriMalAnaliziW extends StatelessWidget {
  const MusteriMalAnaliziW({Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;    
    final RaporController _controller =Get.find();
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,    
    ]);

    int oncekiIndex=0;
    int itemIndex;

    String cariKodu="";
    String unvan="";
    bool btoplamYaz=false;
    bool bSonayaz=false;
    bool bbaslikYaz=false;

    List<MusteriToplamlari> toplamlar=<MusteriToplamlari>[];

    return Obx(()=>WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xff009068),
          title: Text('Müşteri Mal Analizi', style: TextStyle(color: Colors.white, fontSize: size.height * kRaporOranBaslik),),
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
                _controller.setMalzemeGrup();
                await _controller.getMalzemeGrupListesi();
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
                  radius: 1,                
                  content: RaporFiltered(grupGoster: 1, gunlukSiparisR: 0),
                  barrierDismissible: false,
                  onConfirm: () async {
                    _controller.setDataDialog();
                    _controller.setRaporDegerleri();
                    toplamlar.clear();
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
        
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: size.height * 0.098,
                child:MusteriMalAnaliziBaslik(),
              ),
            ),

            SliverFillRemaining(
              child: SizedBox(          
                height: size.height * 0.90,                  
                child: FutureBuilder<List<MusteriMalAnaliziMlzMusToplam>>(              
                  future:_controller.sayac.value>0 ? _controller.getMusteriMalAnalizi():_controller.getMusteriMalAnalizi(),              
                  builder: (BuildContext context, AsyncSnapshot<List<MusteriMalAnaliziMlzMusToplam>> snapshot) {
                    if (snapshot.hasData) {
                      final datas = snapshot.data;

                      List<MusteriMalAnaliziCard> cards = [];
                      int index=0;
                      cards.clear();

                      _controller.maxIndex.value=0;
                      toplamlar.clear();                          
                      _controller.cariKodub.value="";
                      _controller.unvanb.value="";                          
                      cariKodu="";
                      unvan="";                          
                      oncekiIndex=0;

                      for (MusteriMalAnaliziMlzMusToplam item in datas) {
                        
                        itemIndex=0;
                        btoplamYaz=false;
                        bSonayaz=false;                            
                        oncekiIndex>index ? bSonayaz=true:bSonayaz=false;

                        if (cariKodu.toString().toLowerCase().trim()!=item.musteriKodu.toString().toLowerCase().trim() && cariKodu!="")
                        { 
                          itemIndex= bSonayaz==true ? index: index-1; 
                          if (toplamlar.where((element) => element.index==itemIndex).length>0)
                          {
                            MusteriToplamlari toplam=toplamlar.where((element) => element.index==itemIndex).first;

                            _controller.toplamSMiktar.value=toplam.toplamSMiktar;
                            _controller.toplamSTutar.value=toplam.toplamSTutar;
                            _controller.toplamIMiktar.value=toplam.toplamIMiktar;
                            _controller.toplamITutar.value=toplam.toplamITutar;
                            _controller.toplamNMiktar.value=toplam.toplamNMiktar;
                            _controller.toplamKdvsiz.value=toplam.toplamKdvsiz;
                            _controller.cariKodu.value=toplam.carikodu;
                            _controller.unvan.value=toplam.unvan;                  
                            btoplamYaz=true;
                          }                              
                        }

                        if (toplamlar.where((element) => element.carikodu==item.musteriKodu).length==0)
                        {
                          MusteriToplamlari toplam=MusteriToplamlari(
                            carikodu: item.musteriKodu,
                            unvan: item.unvan,
                            index: index,
                            toplamSMiktar: item.satisMiktari,
                            toplamSTutar: item.satisKdvOncesiTutar,
                            toplamIMiktar: item.iadeMiktari,
                            toplamITutar: item.iadeKdvOncesiTutar,
                            toplamNMiktar: item.netMiktar,
                            toplamKdvsiz: item.netKdvOncesiTutar
                          );
                          toplamlar.add(toplam);
                        }
                        else
                        {
                          if (index>_controller.maxIndex.value)
                          {
                            toplamlar.where((element) => element.carikodu==item.musteriKodu).forEach((elementItem) { 
                              elementItem.index=index;
                              elementItem.toplamSMiktar=elementItem.toplamSMiktar + item.satisMiktari;
                              elementItem.toplamSTutar=elementItem.toplamSTutar + item.satisKdvOncesiTutar;
                              elementItem.toplamIMiktar=elementItem.toplamIMiktar + item.iadeMiktari;
                              elementItem.toplamITutar=elementItem.toplamITutar + item.iadeKdvOncesiTutar;
                              elementItem.toplamNMiktar=elementItem.toplamNMiktar + item.netMiktar;
                              elementItem.toplamKdvsiz=elementItem.toplamKdvsiz + item.netKdvOncesiTutar;
                            });
                          }                              
                        }

                        if (snapshot.data.length-1==index && !btoplamYaz)
                        {
                          MusteriToplamlari toplam=toplamlar.where((element) => element.carikodu==item.musteriKodu).first;

                          _controller.toplamSMiktar.value=toplam.toplamSMiktar;
                          _controller.toplamSTutar.value=toplam.toplamSTutar;
                          _controller.toplamIMiktar.value=toplam.toplamIMiktar;
                          _controller.toplamITutar.value=toplam.toplamITutar;
                          _controller.toplamNMiktar.value=toplam.toplamNMiktar;
                          _controller.toplamKdvsiz.value=toplam.toplamKdvsiz;
                          _controller.cariKodu.value=item.musteriKodu.toString();
                          _controller.unvan.value=item.unvan;
                          btoplamYaz=true;
                          bSonayaz=true;
                        }

                        _controller.cariKodub.value=""; 
                        _controller.unvanb.value="";
                        if (index>_controller.maxIndex.value) 
                        {_controller.maxIndex.value=index;}

                        if (oncekiIndex>index) 
                        {
                          _controller.cariKodub.value=item.musteriKodu; 
                          _controller.unvanb.value=item.unvan; 
                        }
                        else
                        {
                          _controller.cariKodub.value=cariKodu; 
                          _controller.unvanb.value=unvan; 
                        }                        

                        bbaslikYaz=false;
                        if (index==0) bbaslikYaz=true;
                        
                        cariKodu=item.musteriKodu;
                        unvan=item.unvan;
                        oncekiIndex=index;
                          
                        cards.add(
                          MusteriMalAnaliziCard(item: item, index: index, btoplamYaz: btoplamYaz, 
                              bSonayaz:bSonayaz, 
                              bbaslikYaz:bbaslikYaz, 
                              grupBazinda: 0,
                              cariKodub: _controller.cariKodub.value,
                              unvanb: _controller.unvanb.value,
                              toplamSMiktar:_controller.toplamSMiktar.value,
                              toplamSTutar:_controller.toplamSTutar.value,
                              toplamIMiktar:_controller.toplamIMiktar.value,
                              toplamITutar: _controller.toplamITutar.value,
                              toplamNMiktar: _controller.toplamNMiktar.value,
                              toplamKdvsiz: _controller.toplamKdvsiz.value
                          ));


                        index=index + 1;
                      }

                      return ListView(
                        addAutomaticKeepAlives: false,
                        children: cards,
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
          child:FutureBuilder<List<MusteriToplamlari>>(
            future: _controller.sayac.value>0 ? _controller.getMusteriMalAnaliziToplam():_controller.getMusteriMalAnaliziToplam(),
            builder: (BuildContext context, AsyncSnapshot<List<MusteriToplamlari>> snapshot) {
              if (snapshot.hasData) {
                  MusteriToplamlari item;
                  item=snapshot.data[0];
                  return 
                  MusteriMalAnaliziToplamW(toplamSMiktar:item.toplamSMiktar==null ? 0.0:item.toplamSMiktar, 
                                  toplamSTutar:item.toplamSTutar==null ? 0.0:item.toplamSTutar,
                                  toplamIMiktar:item.toplamIMiktar==null ? 0.0:item.toplamIMiktar,
                                  toplamITutar:item.toplamITutar==null ? 0.0:item.toplamITutar,
                                  toplamNMiktar:item.toplamNMiktar==null ? 0.0:item.toplamNMiktar,
                                  toplamKdvsiz: item.toplamKdvsiz==null ? 0.0:item.toplamKdvsiz);

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