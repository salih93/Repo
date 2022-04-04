
import 'package:get/get.dart';
import 'package:sdrmobil/VeritabaniIslemleri/siparis_kampanya_bedelsiz.dart';
import 'package:sdrmobil/controller/controller.dart';
import 'package:sdrmobil/controller/siparis_controller.dart';
import 'package:sdrmobil/models/Kampanya/kampanya_toplam.dart';
import 'package:sdrmobil/models/Kampanya/kampanya_toplam_malzeme.dart';
import 'package:sdrmobil/models/Kampanya/kampanya_uygulanacak.dart';
import 'package:flutter/material.dart';
import 'package:sdrmobil/models/Kampanya/kampanya_yuzdesel_satir.dart';
import 'package:sdrmobil/models/Malzeme/birim_cevrimi.dart';
import 'package:sdrmobil/models/Siparis/siparis_satir_list.dart';
import 'package:sdrmobil/providers/db_provider.dart';

class KampanyaUygula {
    
  
  Future<bool> yuzdeselKampanyaUygula(KampanyaUygulanacaklar satirItem, int indirimflag, double indirimTutari, int indirimno, BuildContext context) async {
    final SiparisController _controller =Get.find();
    int previndirimflag;
    double prevIskonto;
    String kindirimler="";

    if (indirimno==1)
    { prevIskonto=satirItem.iskontotutari1;
      previndirimflag=satirItem.indirim01flag;
      satirItem.indirim01flag=indirimflag;
      satirItem.iskontotutari1=indirimTutari;
      
      _controller.secilenUrun.indirim01flag=indirimflag;
      _controller.secilenUrun.iskontotutari1=indirimTutari;
      kindirimler=kindirimler +"%" + indirimTutari.toStringAsFixed(0);
    }
    else
    {
      kindirimler="0";
    }

    if (indirimno==2)
    { prevIskonto=satirItem.iskontotutari2;
      previndirimflag=satirItem.indirim02flag;
      satirItem.indirim02flag=indirimflag;
      satirItem.iskontotutari2=indirimTutari;

      _controller.secilenUrun.indirim02flag=indirimflag;
      _controller.secilenUrun.iskontotutari2=indirimTutari;
      kindirimler=kindirimler +";%" + indirimTutari.toStringAsFixed(0);
    }
    else
    {
      kindirimler=kindirimler + ";0";
    }

    if (indirimno==3)
    { prevIskonto=satirItem.iskontotutari3;
      previndirimflag=satirItem.indirim03flag;
      satirItem.indirim03flag=indirimflag;
      satirItem.iskontotutari3=indirimTutari;

      _controller.secilenUrun.indirim03flag=indirimflag;
      _controller.secilenUrun.iskontotutari3=indirimTutari;
      kindirimler=kindirimler +";%" + indirimTutari.toStringAsFixed(0);
    }
    else
    {
      kindirimler=kindirimler + ";0";
    }

    if (indirimno==4)
    { prevIskonto=satirItem.iskontotutari4;
      previndirimflag=satirItem.indirim04flag;
      satirItem.indirim04flag=indirimflag;
      satirItem.iskontotutari4=indirimTutari;
      _controller.secilenUrun.indirim04flag=indirimflag;
      _controller.secilenUrun.iskontotutari4=indirimTutari;
      kindirimler=kindirimler +";%" + indirimTutari.toStringAsFixed(0);
    }
    else
    {
      kindirimler=kindirimler + ";0";
    }
    
    if (indirimno==5)
    { prevIskonto=satirItem.iskontotutari5;
      previndirimflag=satirItem.indirim05flag;
      satirItem.indirim05flag=indirimflag;
      satirItem.iskontotutari5=indirimTutari;
      _controller.secilenUrun.indirim05flag=indirimflag;
      _controller.secilenUrun.iskontotutari5=indirimTutari;
      kindirimler=kindirimler +";%" + indirimTutari.toStringAsFixed(0);
    }
    else
    {
      kindirimler=kindirimler + ";0";
    }

    if (indirimno==6)
    { prevIskonto=satirItem.iskontotutari6;
      previndirimflag=satirItem.indirim06flag;
      satirItem.indirim06flag=indirimflag;
      satirItem.iskontotutari6=indirimTutari;

      _controller.secilenUrun.indirim06flag=indirimflag;
      _controller.secilenUrun.iskontotutari6=indirimTutari;
      kindirimler=kindirimler +";%" + indirimTutari.toStringAsFixed(0);
    }
    else
    {
      kindirimler=kindirimler + ";0";
    }


    _controller.getSiparisSatirDegerleri(satirItem, context);
    //indirimTutari.toString().replaceAll('.', ',');

    //if (_controller.iskontoKontrol(indirimTutari.toString().replaceAll('.', ','), indirimno))
    //{

    if (!await _controller.tutarHesapla(context))
    {
      if (indirimno==1)
      { satirItem.iskontotutari1=prevIskonto;
        satirItem.indirim01flag=previndirimflag;
      }
      if (indirimno==2)
      { satirItem.iskontotutari2=prevIskonto;
        satirItem.indirim02flag=previndirimflag;
      }
      if (indirimno==3)
      { satirItem.iskontotutari3=prevIskonto;
        satirItem.indirim03flag=previndirimflag;
      }
      if (indirimno==4)
      { satirItem.iskontotutari4=prevIskonto;
        satirItem.indirim04flag=previndirimflag;
      }
      if (indirimno==5)
      { satirItem.iskontotutari5=prevIskonto;
        satirItem.indirim05flag=previndirimflag;
      }
      if (indirimno==6)
      { satirItem.iskontotutari6=prevIskonto;
        satirItem.indirim06flag=previndirimflag;
      }
      return false;
    }

    String indirimler,indirim;
    indirim=(satirItem.indirim01flag==1 ? "%":"") + satirItem.iskontotutari1.toStringAsFixed(0);
    indirimler=indirim;    
    indirim=(satirItem.indirim02flag==1 ? ";%":";") + satirItem.iskontotutari2.toStringAsFixed(0);
    indirimler=indirimler + indirim;
    indirim=(satirItem.indirim03flag==1 ? ";%":";") + satirItem.iskontotutari3.toStringAsFixed(0);
    indirimler=indirimler + indirim;
    indirim=(satirItem.indirim04flag==1 ? ";%":";") + satirItem.iskontotutari4.toStringAsFixed(0);
    indirimler=indirimler + indirim;
    indirim=(satirItem.indirim05flag==1 ? ";%":";") + satirItem.iskontotutari5.toStringAsFixed(0);
    indirimler=indirimler + indirim;
    indirim=(satirItem.indirim06flag==1 ? ";%":";") + satirItem.iskontotutari6.toStringAsFixed(0);
    indirimler=indirimler + indirim;
    satirItem.toplamindirim=_controller.indirimTutari.value;
    satirItem.indirimler=indirimler;
    satirItem.kindirimler=kindirimler;
        
    return true;    
  }

  Future<bool> kampanyaUygula(int mussayac, BuildContext context) async {
    final SiparisController _controller =Get.find();
    final Controller mainController =Get.find();

    
    try {

      _controller.siparissayac.value=mussayac;      
      //Yüzdesel Kampanya

      List<SiparisSatirList> list =await DBProvider.db.getSiparisList(1);
      _controller.siparisIndirim.clear();
      _controller.update();
      List<KampanyaToplam> kampToplam=<KampanyaToplam>[];
      List<KampanyaToplamMalzeme> kampToplamMalzeme=<KampanyaToplamMalzeme>[];
      
      if (mainController.yuzdeselKampanya.value==1)
      {
        List<KampanyaYuzdeselSatir> yuzdeselSatir =await DBProvider.db.getKampanyaYuzdeselSatir(mussayac);
        if (yuzdeselSatir.length>0 && list.length>0)
          await Future.forEach(yuzdeselSatir, (KampanyaYuzdeselSatir satir) async{
            List<SiparisSatirList> satirlist=list.where((a1) => a1.malzemekodu==satir.malzemeKodu).toList();
            if (satirlist.length>0)
            {
                await Future.forEach(satirlist, (SiparisSatirList uk) async{
                if (uk.malzemekodu==satir.malzemeKodu)
                {                
                  if (uk.bazbirim.toString().toLowerCase().trim()!=satir.birim.toString().toLowerCase().trim())
                  {
                    BirimCevrimi birimCevrimi= await DBProvider.db.getBirimCevrimiBirimli(satir.malzemeKodu, uk.bazbirim, satir.birim);
                    if (birimCevrimi.rsayac>0)
                    {
                      uk.miktar=(birimCevrimi.bolunen * uk.miktar)/birimCevrimi.bolen;
                    }
                  }

                  if (satir.miktarSarti>0)
                  {
                    KampanyaToplamMalzeme varmi;
                    double toplamMiktar=uk.miktar;
                    if (kampToplamMalzeme.length>0)
                    {
                      
                      if (kampToplamMalzeme.where((e) => e.kampanyaRsayac==satir.kampanyaRsayac && e.malzemekodu==satir.malzemeKodu).length>0)
                      {
                        varmi=kampToplamMalzeme.firstWhere((e) => e.kampanyaRsayac==satir.kampanyaRsayac && e.malzemekodu==satir.malzemeKodu);                      
                        toplamMiktar=varmi.toplamMiktar + uk.miktar;
                        kampToplamMalzeme.remove(varmi);
                      }                    
                    }
                    kampToplamMalzeme.add(
                      new KampanyaToplamMalzeme(satir.kampanyaRsayac, 
                        satir.malzemeKodu, satir.maxmiktar, satir.minmiktar, satir.kampanyaadi, toplamMiktar, uk.malzemeadi)
                    );
                  }

                  if (satir.minmiktar>0 && satir.maxmiktar>0)
                  {
                    KampanyaToplam varmi;
                    double toplamMiktar=uk.miktar;
                    if (kampToplam.length>0)
                    {                    
                      if (kampToplam.where((e) => e.kampanyaRsayac==satir.kampanyaRsayac && e.grupKodu==satir.grupKodu).length>0)
                      {
                        varmi=kampToplam.firstWhere((e) => e.kampanyaRsayac==satir.kampanyaRsayac && e.grupKodu==satir.grupKodu);
                        toplamMiktar=varmi.toplamMiktar + uk.miktar;
                        kampToplam.remove(varmi);
                      }                    
                    }
                                      
                    kampToplam.add(
                      new KampanyaToplam(satir.kampanyaRsayac, 
                        satir.grupKodu, satir.maxmiktar, satir.minmiktar, satir.kampanyaadi, toplamMiktar, satir.grupAdi)
                    );
                    
                  }
                  
                }                  
            });
            }
        });

        int rowNum=0;        
        if (yuzdeselSatir.length>0)
        {
          await Future.forEach(yuzdeselSatir, (KampanyaYuzdeselSatir element) async{          
            List<SiparisSatirList> satir=list.where((item) => item.malzemekodu==element.malzemeKodu).toList();
            if (satir.length==0 && element.miktarSarti>0)
            {
              int kayitsayisi=_controller.uygulanacakKampanyalar.where((kitem) => kitem.kampanyaRsayac==element.kampanyaRsayac && kitem.grupkodu==element.grupKodu).length;
              if (kayitsayisi>0)
              {
                if (_controller.siparisIndirim.where((kitem) => kitem.indirimkodu==element.kampanyakodu && kitem.grupkodu==element.grupKodu).length>0)
                {
                  _controller.siparisIndirim.removeWhere((kitem) => kitem.indirimkodu==element.kampanyakodu && kitem.grupkodu==element.grupKodu);
                }
                _controller.uygulanacakKampanyalar.removeWhere((kitem) => kitem.kampanyaRsayac==element.kampanyaRsayac && kitem.grupkodu==element.grupKodu);
              }
            }

            await Future.forEach(satir, (SiparisSatirList satirItem) async{          
              bool bIndirimuygula=false;
              if (satirItem.bazbirim.toString().toLowerCase().trim()!=element.birim.toString().toLowerCase().trim())
              {
                BirimCevrimi birimCevrimi= await DBProvider.db.getBirimCevrimiBirimli(satirItem.malzemekodu, satirItem.bazbirim, element.birim);
                if (birimCevrimi.rsayac>0)
                {
                  satirItem.miktar=(birimCevrimi.bolunen * satirItem.miktar)/birimCevrimi.bolen;
                }
              }

              //Min ve Max Miktarlar dolu olduğu halde, miktar sartı zorunlu miktar oluyor.
              if (element.minmiktar>0 && element.maxmiktar>0)
              {
                if (kampToplam.length>0)
                {
                  int sartlaruyuyormu= kampToplam.where((e) => 
                        e.kampanyaRsayac==element.kampanyaRsayac && e.grupKodu==element.grupKodu 
                        && e.minmiktar<=e.toplamMiktar && e.maxmiktar>=e.toplamMiktar
                  ).length;

                  bIndirimuygula=sartlaruyuyormu>0 ? true:false;
                }                         
              }

              if (element.maxmiktar==0 && element.minmiktar==0 && element.miktarSarti>0)
              {
                bIndirimuygula=false;              
                KampanyaToplamMalzeme eSatir=kampToplamMalzeme.firstWhere((a) => a.kampanyaRsayac==element.kampanyaRsayac && a.malzemekodu==element.malzemeKodu);
                eSatir.toplamMiktar>=element.miktarSarti ? bIndirimuygula=true:bIndirimuygula=false;              
              }

              if (bIndirimuygula)
              {
                if (element.minmiktar>0 && element.maxmiktar>0 && element.miktarSarti>0)
                {
                  KampanyaToplamMalzeme eSatir=kampToplamMalzeme.firstWhere((a) => a.kampanyaRsayac==element.kampanyaRsayac && a.malzemekodu==element.malzemeKodu);
                  
                  if (element.miktarSarti>eSatir.toplamMiktar)
                  {
                    bIndirimuygula=false;

                    int kayitsayisi=_controller.uygulanacakKampanyalar.where((kitem) => kitem.kampanyaRsayac==element.kampanyaRsayac && kitem.grupkodu==element.grupKodu).length;
                    if (kayitsayisi>0)
                    { 
                        if (_controller.siparisIndirim.where((kitem) => kitem.indirimkodu==element.kampanyakodu && kitem.grupkodu==element.grupKodu).length>0)
                        {
                          _controller.siparisIndirim.removeWhere((kitem) => kitem.indirimkodu==element.kampanyakodu && kitem.grupkodu==element.grupKodu);
                        }                    
                        _controller.uygulanacakKampanyalar.removeWhere((kitem) => kitem.kampanyaRsayac==element.kampanyaRsayac && kitem.grupkodu==element.grupKodu);                 
                    }
                                    
                  }
                }            
              }
            
            if (bIndirimuygula)
            {            

              _controller.secilenUrun=_controller.malzemeDetay.firstWhere((b) => b.malzemekodu==element.malzemeKodu);
              KampanyaUygulanacaklar kampItemUygulanacak=
                KampanyaUygula2().uygulanacakKampanyaAyarla(satirItem, element.kampanyaadi,0,1, element.kampanyaRsayac);

              if (kampItemUygulanacak!=null) kampItemUygulanacak.kgrupAdi=element.grupAdi;

                bool bKampanyaUygulandi=false;
                if (element.indirim01>0)
                {
                  if (!await yuzdeselKampanyaUygula(kampItemUygulanacak, 1, element.indirim01,1, context))
                  {                  
                    Get.snackbar("Uyarı", "Yüzdesel indirim,${kampItemUygulanacak.rowNum} nolu satır için uygulanamadı.",backgroundColor: Color(0xff0000), 
                      colorText: Color(0xffffff), 
                      duration: Duration(seconds: 5),);
                    return;
                  }
                  rowNum=rowNum + 1;
                  kampItemUygulanacak.rowNum=rowNum;
                  kampItemUygulanacak.grupkodu=element.grupKodu;
                  kampItemUygulanacak.zorunlu=element.zorunlu;
                  if (element.zorunlu==1) kampItemUygulanacak.secim=1;
                  _controller.uygulanacakKampanyalar.add(kampItemUygulanacak);
                  bKampanyaUygulandi=true; 
                  KampanyaUygula2().siparisIndirimiEkle(kampItemUygulanacak, element.indirim01, 1, 'Y', element.kampanyakodu);                
                }

                if (element.indirim02>0)
                {
                  if (!await yuzdeselKampanyaUygula(kampItemUygulanacak, 1, element.indirim02,2, context))
                  {                  
                    Get.snackbar("Uyarı", "Yüzdesel indirim,${kampItemUygulanacak.rowNum} nolu satır için uygulanamadı.",backgroundColor: Color(0xff0000), 
                      colorText: Color(0xffffff), 
                      duration: Duration(seconds: 5),);
                    return;
                  }
                  if (!bKampanyaUygulandi)
                  { rowNum=rowNum + 1;
                    kampItemUygulanacak.rowNum=rowNum;
                    bKampanyaUygulandi=true;
                  }
                  else 
                  { KampanyaUygulanacaklar uygu=_controller.uygulanacakKampanyalar.firstWhere((kitem) => kitem.rowNum==rowNum);
                    if (uygu!=null)
                      _controller.uygulanacakKampanyalar.remove(uygu);

                    kampItemUygulanacak.rowNum=rowNum;
                  }
                  KampanyaUygula2().siparisIndirimiEkle(kampItemUygulanacak, element.indirim02, 2,'Y', element.kampanyakodu);
                  kampItemUygulanacak.zorunlu=element.zorunlu;
                  if (element.zorunlu==1) kampItemUygulanacak.secim=1;
                  _controller.uygulanacakKampanyalar.add(kampItemUygulanacak);                
                }
                if (element.indirim03>0)
                {
                  if (!await yuzdeselKampanyaUygula(kampItemUygulanacak, 1, element.indirim03,3, context))
                  {                  
                    Get.snackbar("Uyarı", "Yüzdesel indirim,${kampItemUygulanacak.rowNum} nolu satır için uygulanamadı.",backgroundColor: Color(0xff0000),
                      colorText: Color(0xffffff), 
                      duration: Duration(seconds: 5),);
                    return;
                  }
                  if (!bKampanyaUygulandi)
                  { rowNum=rowNum + 1;
                    kampItemUygulanacak.rowNum=rowNum;
                    bKampanyaUygulandi=true;
                  }
                  else 
                  { KampanyaUygulanacaklar uygu=_controller.uygulanacakKampanyalar.firstWhere((kitem) => kitem.rowNum==rowNum);
                    if (uygu!=null)
                      _controller.uygulanacakKampanyalar.remove(uygu);

                    kampItemUygulanacak.rowNum=rowNum;
                  }
                  KampanyaUygula2().siparisIndirimiEkle(kampItemUygulanacak, element.indirim03, 3,'Y', element.kampanyakodu);
                  kampItemUygulanacak.zorunlu=element.zorunlu;
                  if (element.zorunlu==1) kampItemUygulanacak.secim=1;
                  _controller.uygulanacakKampanyalar.add(kampItemUygulanacak);
                  _controller.update();
                }

                if (element.indirim04>0)
                {
                  if (!await yuzdeselKampanyaUygula(kampItemUygulanacak, 1, element.indirim04,4, context))
                  {                  
                    Get.snackbar("Uyarı", "Yüzdesel indirim,${kampItemUygulanacak.rowNum} nolu satır için uygulanamadı.",backgroundColor: Color(0xff0000),
                      colorText: Color(0xffffff), 
                      duration: Duration(seconds: 5),);
                    return;
                  }
                  if (!bKampanyaUygulandi)
                  { rowNum=rowNum + 1;
                    kampItemUygulanacak.rowNum=rowNum;
                    bKampanyaUygulandi=true;
                  }
                  else 
                  { KampanyaUygulanacaklar uygu=_controller.uygulanacakKampanyalar.firstWhere((kitem) => kitem.rowNum==rowNum);
                    if (uygu!=null)
                      _controller.uygulanacakKampanyalar.remove(uygu);                    
                    kampItemUygulanacak.rowNum=rowNum;
                  }
                  KampanyaUygula2().siparisIndirimiEkle(kampItemUygulanacak, element.indirim04, 4,'Y', element.kampanyakodu);
                  kampItemUygulanacak.zorunlu=element.zorunlu;
                  if (element.zorunlu==1) kampItemUygulanacak.secim=1;
                  _controller.uygulanacakKampanyalar.add(kampItemUygulanacak);
                  _controller.update();
                }

                if (element.indirim05>0)
                {
                  if (!await yuzdeselKampanyaUygula(kampItemUygulanacak, 1, element.indirim05,5, context))
                  {                  
                    Get.snackbar("Uyarı", "Yüzdesel indirim,${kampItemUygulanacak.rowNum} nolu satır için uygulanamadı.",backgroundColor: Color(0xff0000),
                      colorText: Color(0xffffff), 
                      duration: Duration(seconds: 5),);
                    return;
                  }                
                  if (!bKampanyaUygulandi)
                  { rowNum=rowNum + 1;
                    kampItemUygulanacak.rowNum=rowNum;
                    bKampanyaUygulandi=true;
                  }
                  else 
                  { KampanyaUygulanacaklar uygu=_controller.uygulanacakKampanyalar.firstWhere((kitem) => kitem.rowNum==rowNum);
                    _controller.uygulanacakKampanyalar.remove(uygu);
                    kampItemUygulanacak.rowNum=rowNum;
                  }
                  KampanyaUygula2().siparisIndirimiEkle(kampItemUygulanacak, element.indirim05, 5,'Y', element.kampanyakodu);
                  kampItemUygulanacak.zorunlu=element.zorunlu;
                  if (element.zorunlu==1) kampItemUygulanacak.secim=1;
                  _controller.uygulanacakKampanyalar.add(kampItemUygulanacak);
                  _controller.update();
                }

                if (element.indirim06>0)
                {            
                  if (!await yuzdeselKampanyaUygula(kampItemUygulanacak, 1, element.indirim06,6, context))
                  {                  
                    Get.snackbar("Uyarı", "Yüzdesel indirim,${kampItemUygulanacak.rowNum} nolu satır için uygulanamadı.",backgroundColor: Color(0xff0000),
                      colorText: Color(0xffffff), 
                      duration: Duration(seconds: 5),);                    
                      return;
                  }
                  if (!bKampanyaUygulandi)
                  { rowNum=rowNum + 1;
                    kampItemUygulanacak.rowNum=rowNum;
                    bKampanyaUygulandi=true;
                  }
                  else 
                  { KampanyaUygulanacaklar uygu=_controller.uygulanacakKampanyalar.firstWhere((kitem) => kitem.rowNum==rowNum);
                    _controller.uygulanacakKampanyalar.remove(uygu);
                    kampItemUygulanacak.rowNum=rowNum;
                  }
                  KampanyaUygula2().siparisIndirimiEkle(kampItemUygulanacak, element.indirim06, 6,'Y', element.kampanyakodu);
                  kampItemUygulanacak.zorunlu=element.zorunlu;
                  if (element.zorunlu==1) kampItemUygulanacak.secim=1;
                  _controller.uygulanacakKampanyalar.add(kampItemUygulanacak);
                  _controller.update();
                }

              
                  
              }

          });

          });
              
        }
      }
      //Yüzdesel Kampanya bitişi

      //bedelsiz Kampanya
      if (mainController.bedelsizKampanya.value==1)
        await KampanyaUygula2().bedelsizKampanyaUygula(mussayac, context);


    } 
    catch (e) {
      print(e.toString());
      Get.snackbar("Hata", "Siparişe kampanya uygulanamadı.",backgroundColor: Color(0xff0000), colorText: Color(0xffffff), 
        duration: Duration(seconds: 5),);
      return false;
    }

    return true;
  }
  
  
}
