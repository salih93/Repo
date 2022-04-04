import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sdrmobil/Screens/Raporlar/AcikHesapListesi/acik_hesap_listesi_card.dart';
import 'package:sdrmobil/Screens/Raporlar/rapor_filtered.dart';
import 'package:sdrmobil/Screens/Raporlar/raporlar_ana_menu.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/controller/rapor_controller.dart';
import 'package:sdrmobil/models/Raporlar/acik_hesap_listesi.dart';
import 'package:sdrmobil/models/Raporlar/musteri_toplamlari.dart';

class AcikHesapListesiW extends StatelessWidget {
  const AcikHesapListesiW({Key key }) : super(key: key);

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
          title: Text('Açık Hesap Listesi', style: TextStyle(color: Colors.white, fontSize: size.height * kRaporOranBaslik),),
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
                  radius: 1,                
                  content: RaporFiltered(grupGoster: 0, gunlukSiparisR: 0),
                  barrierDismissible: false,
                  onConfirm: () async {
                    toplamlar.clear();
                    _controller.setDataDialog();                  
                    _controller.setRaporDegerleri();
                    Navigator.maybeOf(context).pop();                
                    
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
              height: size.height * 0.90,                  
              child: FutureBuilder<List<AcikHesapListesi>>(              
                future:_controller.sayac.value>0 ? _controller.getAcikHesapListesi():_controller.getAcikHesapListesi(),              
                builder: (BuildContext context, AsyncSnapshot<List<AcikHesapListesi>> snapshot) {
                  if (snapshot.hasData) {

                    final datas = snapshot.data;
                    List<AcikHesapListesiCard> cards = [];
                    int index=0;
                    cards.clear();

                    _controller.maxIndex.value=0;
                    toplamlar.clear();                          
                    _controller.cariKodub.value="";
                    _controller.unvanb.value="";                          
                    cariKodu="";
                    unvan="";                          
                    oncekiIndex=0;

                    double endtoplamITutar=0;
                    double endtoplamNMiktar=0;
                    double endtoplamKdvsiz=0;

                    for (AcikHesapListesi item in datas) {
                      btoplamYaz=false;
                      bSonayaz=false;
                      itemIndex=0;
                      endtoplamITutar=0;
                      endtoplamNMiktar=0;
                      endtoplamKdvsiz=0;

                      oncekiIndex>index ? bSonayaz=true:bSonayaz=false;
                    
                      if (cariKodu.trim()!=item.cariKodu.trim() && cariKodu!="")
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

                      if (toplamlar.where((element) => element.carikodu==item.cariKodu).length==0)
                      {
                        MusteriToplamlari toplam=MusteriToplamlari(
                          carikodu: item.cariKodu,
                          unvan: item.cariUnvan,
                          index: index,
                          toplamSMiktar: 0,
                          toplamSTutar: 0,
                          toplamIMiktar: 0,
                          toplamITutar: item.tefatTutari,
                          toplamNMiktar: item.tefatBakiyeTutari,
                          toplamKdvsiz: item.bakiyeToplami
                        );
                        toplamlar.add(toplam);
                      }
                      else
                      {
                        if (index>_controller.maxIndex.value)
                        {
                          toplamlar.where((element) => element.carikodu==item.cariKodu).forEach((elementItem) { 
                            elementItem.index=index;
                            elementItem.toplamSMiktar=0;
                            elementItem.toplamSTutar=0;
                            elementItem.toplamIMiktar=0;
                            elementItem.toplamITutar=elementItem.toplamITutar + item.tefatTutari;
                            elementItem.toplamNMiktar=elementItem.toplamNMiktar + item.tefatBakiyeTutari;
                            elementItem.toplamKdvsiz=item.bakiyeToplami;
                          });
                        }                              
                      }


                      if (snapshot.data.length-1==index && !btoplamYaz)
                      {
                        MusteriToplamlari toplam=toplamlar.where((element) => element.carikodu==item.cariKodu).first;

                        _controller.toplamSMiktar.value=toplam.toplamSMiktar;
                        _controller.toplamSTutar.value=toplam.toplamSTutar;
                        _controller.toplamIMiktar.value=toplam.toplamIMiktar;
                        _controller.toplamITutar.value=toplam.toplamITutar;
                        _controller.toplamNMiktar.value=toplam.toplamNMiktar;
                        _controller.toplamKdvsiz.value=toplam.toplamKdvsiz;
                        endtoplamITutar=toplam.toplamITutar;
                        endtoplamNMiktar=toplam.toplamNMiktar;
                        endtoplamKdvsiz=toplam.toplamKdvsiz;

                        _controller.cariKodu.value=item.cariKodu.toString();
                        _controller.unvan.value=item.cariUnvan;
                        btoplamYaz=true;
                        bSonayaz=true;
                      }

                      if (snapshot.data.length-1==index && btoplamYaz && !bSonayaz)
                      {
                        endtoplamITutar=item.tefatTutari;
                        endtoplamNMiktar=item.tefatBakiyeTutari;
                        endtoplamKdvsiz=item.bakiyeToplami;
                      }

                      _controller.endIndex.value=snapshot.data.length-1;                       
                      if (index>_controller.maxIndex.value) 
                      {
                        _controller.maxIndex.value=index;                        
                      }

                      if (oncekiIndex>index)
                      {                        
                        _controller.cariKodub.value=cariKodu.trim();
                        _controller.unvanb.value=unvan.trim(); 
                      }
                      else
                      {
                        _controller.cariKodub.value=item.cariKodu.trim(); 
                        _controller.unvanb.value=item.cariUnvan.trim();
                      }

                        
                        bbaslikYaz=false;
                        if (index==0) bbaslikYaz=true;
                        
                        cariKodu=item.cariKodu;
                        unvan=item.cariUnvan;
                        oncekiIndex=index;
                   

                        cards.add(
                          AcikHesapListesiCard(item: item, index: index, btoplamYaz: btoplamYaz, 
                            bSonayaz:bSonayaz, 
                            bbaslikYaz:bbaslikYaz, 
                            grupBazinda: 0,
                            cariKodub: _controller.cariKodub.value,
                            unvanb: _controller.unvanb.value,
                            toplamITutar: _controller.toplamITutar.value,
                            toplamNMiktar: _controller.toplamNMiktar.value,
                            toplamKdvsiz: _controller.toplamKdvsiz.value,
                            endtoplamITutar:endtoplamITutar,
                            endtoplamKdvsiz: endtoplamKdvsiz,
                            endtoplamNMiktar: endtoplamNMiktar,
                          ),
                        );

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
      ),
    ),
    );

  }
}