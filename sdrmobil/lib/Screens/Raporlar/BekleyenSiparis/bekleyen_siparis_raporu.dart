import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:sdrmobil/Screens/Raporlar/BekleyenSiparis/bekleyen_siparis_raporu_card.dart';
import 'package:sdrmobil/Screens/Raporlar/rapor_filtered.dart';
import 'package:sdrmobil/Screens/Raporlar/raporlar_ana_menu.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/controller/rapor_controller.dart';
import 'package:sdrmobil/models/Raporlar/siparis_toplamlari.dart';
import 'package:sdrmobil/models/Siparis/bekleyen_siparis.dart';

class BekleyenSiparisRaporu extends StatelessWidget {
  const BekleyenSiparisRaporu({Key key }) : super(key: key);

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

    String siparisno="";
    DateTime siparistarihi;
    String siparisasama=""; 

    bool btoplamYaz=false;
    bool bSonayaz=false;
    bool bbaslikYaz=false;

    List<SiparisToplamlari> toplamlar=<SiparisToplamlari>[];
    

    return Obx(()=>WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xff009068),
          title: Text('Bekleyen Sipariş Raporu', style: TextStyle(color: Colors.white, fontSize: size.height * kRaporOranBaslik),),
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
                  content: RaporFiltered(grupGoster: 1, gunlukSiparisR: 0,),
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
                      child: FutureBuilder<List<BekleyenSiparis>>(              
                        future:_controller.sayac.value>0 ? _controller.getAllBekleyenSiparis():_controller.getAllBekleyenSiparis(),              
                        builder: (BuildContext context, AsyncSnapshot<List<BekleyenSiparis>> snapshot) {
                          if (snapshot.hasData) {
                            
                            final datas = snapshot.data;
                            List<BekleyenSiparisRaporuCard> cards = [];
                            int index=0;
                            cards.clear();
                            _controller.maxIndex.value=0;
                            toplamlar.clear();
                            siparisno="";
                            _controller.cariKodub.value="";
                            _controller.unvanb.value="";
                            _controller.siparisno.value="";
                            _controller.siparistarihi=DateTime.now();
                            _controller.siparisasama.value="";
                            cariKodu="";
                            unvan="";
                            siparistarihi=DateTime.now();
                            oncekiIndex=0;
                            siparisasama="";
                            

                            for (BekleyenSiparis item in datas) {
                              btoplamYaz=false;
                              bSonayaz=false;
                              itemIndex=0;

                              oncekiIndex>index ? bSonayaz=true:bSonayaz=false;
                              if (siparisno!=item.siparisno.toString() && siparisno!="")
                              { 
                                itemIndex= bSonayaz==true ? index: index-1; 
                                if (toplamlar.where((element) => element.index==itemIndex).length>0)
                                {
                                  SiparisToplamlari toplam=toplamlar.where((element) => element.index==itemIndex).first;
                                  _controller.toplamSTutar.value=toplam.toplamSTutar;
                                  btoplamYaz=true;
                                }                              
                              }

                              if (toplamlar.where((element) => element.siparisno==item.siparisno.toString()).length==0)
                              {
                                SiparisToplamlari toplam=SiparisToplamlari(
                                  siparisno: item.siparisno.toString(),
                                  index: index,                          
                                  toplamSTutar: item.satirtutari
                                );
                                toplamlar.add(toplam);
                              }
                              else
                              {
                                if (index>_controller.maxIndex.value)
                                {
                                  toplamlar.where((element) => element.siparisno==item.siparisno.toString()).forEach((elementItem) { 
                                    elementItem.index=index;                            
                                    elementItem.toplamSTutar=elementItem.toplamSTutar + item.satirtutari;                            
                                  });
                                }
                              }

                              if (snapshot.data.length-1==index && !btoplamYaz)
                              {
                                SiparisToplamlari toplam=toplamlar.where((element) => element.siparisno==item.siparisno.toString()).first;                        
                                _controller.toplamSTutar.value=toplam.toplamSTutar;
                                btoplamYaz=true;
                                bSonayaz=true;                                
                              }

                              if (index>_controller.maxIndex.value) 
                              {
                                _controller.maxIndex.value=index;                        
                              }

                              if (oncekiIndex>index)
                              {                        
                                _controller.cariKodub.value=cariKodu;
                                _controller.unvanb.value=unvan;
                                _controller.siparisno.value=siparisno;
                                _controller.siparistarihi=siparistarihi;
                                _controller.siparisasama.value=siparisasama;
                              }
                              else
                              {
                                _controller.cariKodub.value=item.musterino; 
                                _controller.unvanb.value=item.unvan;
                                _controller.siparisno.value=item.siparisno.toString();
                                _controller.siparistarihi=item.siparistarihi;
                                _controller.siparisasama.value=item.siparisasama;
                              }

                              bbaslikYaz=false;
                              if (index==0) 
                              { bbaslikYaz=true; 
                                _controller.siparisno.value=item.siparisno.toString();
                              }

                              cariKodu=item.musterino;
                              unvan=item.unvan;
                              siparisno=item.siparisno.toString();
                              siparistarihi=item.siparistarihi;
                              oncekiIndex=index;
                              siparisasama=item.siparisasama;
                              
                              cards.add(BekleyenSiparisRaporuCard(item: item, index: index, btoplamYaz: btoplamYaz, 
                                bSonayaz:bSonayaz, bbaslikYaz:bbaslikYaz, grupBazinda: 0,
                                siparisno: _controller.siparisno.value,
                                siparisasama: _controller.siparisasama.value,
                                siparistarihi: _controller.siparistarihi,
                                cariKodub: _controller.cariKodub.value,
                                unvanb: _controller.unvanb.value,
                                toplamSTutar: _controller.toplamSTutar.value
                                )
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