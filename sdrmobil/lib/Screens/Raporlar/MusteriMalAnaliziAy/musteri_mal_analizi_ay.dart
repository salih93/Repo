
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sdrmobil/Screens/Raporlar/MusteriMalAnaliziAy/musteri_mal_analizi_ay_card.dart';
import 'package:sdrmobil/Screens/Raporlar/MusteriMalAnaliziAy/musteri_mal_analizi_ay_expand.dart';
import 'package:sdrmobil/Screens/Raporlar/rapor_filtered.dart';
import 'package:sdrmobil/Screens/Raporlar/raporlar_ana_menu.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/controller/rapor_controller.dart';
import 'package:sdrmobil/models/Raporlar/musteri_mal_analiz_ay_toplam.dart';
import 'package:sdrmobil/models/Raporlar/musteri_mal_analizi_ay.dart';



class MusteriMalAnaliziAyW extends StatelessWidget {
  const MusteriMalAnaliziAyW({Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;    
    final RaporController _controller =Get.find();
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,    
    ]);


    String cariKodu="";
    String unvan="";


    List<MusteriMalAnaliziAyExpand> musteriler=<MusteriMalAnaliziAyExpand>[];
    List<MusteriMalAnaliziAyToplam> toplamlar=<MusteriMalAnaliziAyToplam>[];

    return Obx(()=>Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xff009068),
        title: Text('Müşteri Mal Analizi Ay Bazında', style: TextStyle(color: Colors.white, fontSize: size.height * kRaporOranBaslik),),
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
            constraints: BoxConstraints(maxHeight: 44),
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
                content: RaporFiltered(grupGoster: 1, gunlukSiparisR: 0,),
                barrierDismissible: false,
                onConfirm: () async {
                  toplamlar.clear();                  
                  _controller.setDataDialog();
                  _controller.setRaporDegerleri();                  
                  //_controller.update();

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
              height: size.height * 0.040,              
              child:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: size.height * 0.01,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("", style: TextStyle(fontSize: size.height * kMusteriMalBasOran, fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),

                        Expanded(
                          flex: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Net Miktar", style: TextStyle(fontSize: size.height * kMusteriMalBasOran, fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),

                        Expanded(
                          flex: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Net Tutar", style: TextStyle(fontSize: size.height * kMusteriMalBasOran, fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                        
                      ],
                    ),
                  ],
                ),
              ),
            ),
          


          SliverFillRemaining(
            child: SizedBox(          
              height: size.height * 0.95,                  
              child: FutureBuilder<List<MusteriMalAnaliziAy>>(              
                future:_controller.sayac.value>0 ? _controller.getMusteriMalAnaliziAy():_controller.getMusteriMalAnaliziAy(),
                builder: (BuildContext context, AsyncSnapshot<List<MusteriMalAnaliziAy>> snapshot) {
                  if (snapshot.hasData) {
                    final datas = snapshot.data;
                     List<MusteriMalAnaliziCardAy> cards = [];
                    int index=0;                    
                    toplamlar=<MusteriMalAnaliziAyToplam>[];
                    musteriler=<MusteriMalAnaliziAyExpand>[];
                    cariKodu="";
                    unvan="";
                    _controller.maxIndex.value=0;                    
                    _controller.cariKodub.value="";
                    _controller.unvanb.value=""; 

                                        
                    String malzemeKodu="";
                    
                    for (MusteriMalAnaliziAy item in datas) {
                     
                      if (toplamlar.where((element) => element.musteriKodu==item.musteriKodu && element.malzemeKodu==item.malzemeKodu).length==0)
                      {

                        if (cariKodu!="")
                        {
                          if (toplamlar.where((element) => 
                            element.musteriKodu==cariKodu && element.malzemeKodu==malzemeKodu).length>0)
                          {
                            MusteriMalAnaliziAyToplam t = toplamlar.firstWhere((element) => element.musteriKodu==cariKodu 
                                                            && element.malzemeKodu==malzemeKodu);
                            cards.add(MusteriMalAnaliziCardAy(item: t, index: index ));

                            toplamlar =<MusteriMalAnaliziAyToplam>[];
                          }                          
                          if (cariKodu.toLowerCase().trim()!=item.musteriKodu.toLowerCase().trim() && cariKodu!="")
                          {                         
                            MusteriMalAnaliziAyExpand musteri=MusteriMalAnaliziAyExpand(cariKodu, unvan, cards);                        
                            musteriler.add(musteri);
                            cards=<MusteriMalAnaliziCardAy>[];
                          }
                        }

                        MusteriMalAnaliziAyToplam toplam=MusteriMalAnaliziAyToplam(
                          musteriKodu: item.musteriKodu,
                          unvan: item.unvan, ay1: item.ay,
                          ay1netMiktar: item.netMiktar,
                          ay1netTutar: item.netTutar,
                          ay2: "", ay2netMiktar: 0, ay2netTutar: 0, 
                          ay3: "", ay3netMiktar: 0, ay3netTutar: 0,
                          malzemeKodu: item.malzemeKodu,
                          malzemeAdi: item.malzemeAdi
                        );
                        toplamlar.add(toplam);
                      }
                      else
                      {                        
                        toplamlar.where((element) => element.musteriKodu==item.musteriKodu && element.malzemeKodu==item.malzemeKodu).forEach((elementItem) {
                          bool bBulundu=false;
                          if (elementItem.ay1==item.ay)
                          {
                            elementItem.ay1netMiktar=elementItem.ay1netMiktar + item.netMiktar;
                            elementItem.ay1netTutar=elementItem.ay1netTutar + item.netTutar;
                            bBulundu=true;
                          }                          
                          if (elementItem.ay2==item.ay)
                          {
                            elementItem.ay2netMiktar=elementItem.ay2netMiktar + item.netMiktar;
                            elementItem.ay2netTutar=elementItem.ay2netTutar + item.netTutar;
                            bBulundu=true;
                          }                           
                          if (elementItem.ay3==item.ay)
                          {
                            elementItem.ay3netMiktar=elementItem.ay3netMiktar + item.netMiktar;
                            elementItem.ay3netTutar=elementItem.ay3netTutar + item.netTutar;
                            bBulundu=true;
                          }
                          if (!bBulundu)
                          {
                            bBulundu=false;
                            if (elementItem.ay2=="")
                            {
                              elementItem.ay2=item.ay;
                              elementItem.ay2netMiktar=elementItem.ay2netMiktar + item.netMiktar;
                              elementItem.ay2netTutar=elementItem.ay2netTutar + item.netTutar;
                              bBulundu=true;
                            }
                            if (elementItem.ay3=="" && !bBulundu)
                            {
                              elementItem.ay3=item.ay;
                              elementItem.ay2netMiktar=elementItem.ay2netMiktar + item.netMiktar;
                              elementItem.ay2netTutar=elementItem.ay2netTutar + item.netTutar;
                            }
                          }
                        });                        
                      }

                      cariKodu=item.musteriKodu;
                      unvan=item.unvan;                      
                      malzemeKodu=item.malzemeKodu;

                      index=index + 1;
                    }

                    if (toplamlar.where((element) => 
                        element.musteriKodu==cariKodu && element.malzemeKodu==malzemeKodu).length>0)
                    {
                      MusteriMalAnaliziAyToplam t1 = toplamlar.firstWhere((element) => element.musteriKodu==cariKodu 
                                                          && element.malzemeKodu==malzemeKodu);
                      cards.add(MusteriMalAnaliziCardAy(item: t1, index: index ));

                      MusteriMalAnaliziAyExpand musteri=MusteriMalAnaliziAyExpand(cariKodu, unvan, cards);                        
                      musteriler.add(musteri);
                    }

                    return ListView(
                      addAutomaticKeepAlives: false,
                      children: musteriler,
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
    );
  }
}