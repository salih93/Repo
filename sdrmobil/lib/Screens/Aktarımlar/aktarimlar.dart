import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdrmobil/Screens/Aktar%C4%B1mlar/aktarim_gosterge_card.dart';
import 'package:sdrmobil/Screens/Aktar%C4%B1mlar/aktarim_gosterge_card2.dart';
import 'package:sdrmobil/Screens/Aktar%C4%B1mlar/siparis_aktarimi.dart';
import 'package:sdrmobil/Screens/Aktar%C4%B1mlar/tahsilat_aktarimi.dart';
import 'package:sdrmobil/Screens/Aktar%C4%B1mlar/ziyaret_aktarimi.dart';
import 'package:sdrmobil/VeritabaniIslemleri/veri_islemleri.dart';
import 'package:sdrmobil/components/get_snackbar.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/controller/controller.dart';
import 'package:sdrmobil/models/validation_response.dart';
import 'package:sdrmobil/providers/db_provider.dart';

class Aktarimlar extends StatelessWidget {
  const Aktarimlar({ Key key }) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    final Controller _controller = Get.find();
    Size size = MediaQuery.of(context).size;    
    
    return SingleChildScrollView(        
      child: Column(        
        children: [
          AktarimGostergesiCard(baslik: 'Ziyaretler', 
            baslikArkaplanRengi: Colors.blue,
            altBaslik1: 'Rut Dışı: ',
            altBaslik2: 'Rut İçi : ',
            altBaslikvalue1: _controller.rutdisi.value,
            altBaslikvalue2: _controller.rutici.value,),

          AktarimGostergesiCard(baslik: 'Satışlar', 
            baslikArkaplanRengi: Colors.green,
            altBaslik1: 'Siparişler: ',
            altBaslik2: 'Faturalar : ',
            altBaslikvalue1: _controller.siparisSayisi.value,
            altBaslikvalue2: _controller.fatura.value,),

          AktarimGostergesiCard2(baslik: 'Tahsilatlar',
            baslikArkaplanRengi: Colors.cyan[700],
            value: _controller.tahsilat.value.toString(),),
            
          AktarimGostergesiCard2(baslik: 'Potansiyel Müşteriler',
            baslikArkaplanRengi: Colors.blue[900],
            value: '0',),

          AktarimGostergesiCard2(baslik: 'Veri Özeti',
            baslikArkaplanRengi: Colors.cyan[700],
            value: "Son Güncelleme Tarihi: " + _controller.aktarimDurumu.value,),

          SizedBox(height: size.height * 0.0125,),

          Container(
            height: size.height * 0.25,            
            child: Card(
              child: Column(
                children: [
                  ListTile(
                    title:Container(
                      height: size.height * 0.06,
                      child: TextButton(
                        style: TextButton.styleFrom(                        
                          textStyle: TextStyle(fontSize: size.height * kaktarimbasoran),
                          backgroundColor: Color(0xff009068),
                        ),

                        child: Text("Aktarımı Başlat", style: TextStyle(color: Colors.white),),
                        onPressed:()async{
                          _controller.isAktarimlar.value=true;
                          if (_controller.ziyaretId.value>0)
                          {
                            snackbar("Uyarı", "Önce ziyareti sonlandırmalısınız.", Icons.person);
                            return false;
                          }

                          if (await TahsilatAktarimi().verileriAktar())
                          {
                            //snackbar("Bilgi", "Tahsilat verileri başarıyla aktarıldı.", Icons.person);
                          }

                          if (await SiparisAktarimi().verileriAktar())
                          {
                            //snackbar("Bilgi", "Sipariş verileri başarıyla aktarıldı.", Icons.person);
                          }

                          if (await ZiyaretAktarimi().verileriAktar())
                          {
                            //snackbar("Bilgi", "Tahsilat verileri başarıyla aktarıldı.", Icons.person);
                          }

                          ValidationResponse vr= ValidationResponse(successful: true, information: "");
                          vr=await DBProvider.db.deleteAllZiyaret();
                          if (!vr.successful)
                          {
                            _controller.isLoading.value=false;
                            _controller.update();
                            snackbar("Uyarı", 'Ziyaretler silinemedi.'+vr.information, Icons.person);
                            return false;
                          }
                          
                          if (await VeriIslemleri().loadFromApi())
                          {
                            snackbar("Bilgi", "Aktarımlar başarıyla tamamlandı.", Icons.person);                
                            _controller.isAktarimlar.value=false;
                            _controller.menuGoruntule.value=0;
                            _controller.update();
                          }
                          VeriIslemleri().loadFromRaporlar(1);

                          _controller.isAktarimlar.value=false;
                          await _controller.siparisTahsilatControl();                          
                        }
                      ),
                    ),
                  ),
                  
                  ListTile(
                    title: Container(
                      height: size.height * 0.06,
                      child: TextButton(
                          style: TextButton.styleFrom(                  
                          textStyle: TextStyle(fontSize: size.height * kaktarimbasoran),
                          backgroundColor: _controller.siparisTahsilatSayisi.value>0 ? Colors.black12 :Colors.red,
                        ),                  
                        child: Text(" Veri Güncelle ", style: TextStyle(color: Colors.white),),
                        onPressed:_controller.siparisTahsilatSayisi.value>0 ? null: ()async{
                          _controller.isAktarimlar.value=true;
                          if (_controller.ziyaretId.value>0)
                          {
                            snackbar("Uyarı", "Önce ziyareti sonlandırmalısınız.", Icons.person);
                            return;
                          }                                                
                          if (await VeriIslemleri().loadFromApi())
                          {
                            snackbar("Bilgi", "Aktarımlar başarıyla tamamlandı.", Icons.person);                
                            _controller.isAktarimlar.value=false;
                            _controller.menuGoruntule.value=0;
                            _controller.update();
                          }
                          VeriIslemleri().loadFromRaporlar(1);
                          _controller.isAktarimlar.value=false;
                        }
                      ),
                    ),
                  ),
                ],  

    
              ),
            ),
          ),

        ],
      ),
    );

  }
}


