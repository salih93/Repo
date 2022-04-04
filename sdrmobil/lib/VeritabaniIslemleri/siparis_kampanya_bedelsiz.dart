
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sdrmobil/VeritabaniIslemleri/siparis_kampanya_uygula.dart';
import 'package:sdrmobil/VeritabaniIslemleri/siparis_veri_islemleri.dart';
import 'package:sdrmobil/components/get_snackbar.dart';
import 'package:sdrmobil/controller/controller.dart';
import 'package:sdrmobil/controller/siparis_controller.dart';
import 'package:sdrmobil/models/Kampanya/kampanya_bedelsiz_satir.dart';
import 'package:sdrmobil/models/Kampanya/kampanya_bedelsiz_verilen.dart';
import 'package:sdrmobil/models/Kampanya/kampanya_uygulanacak.dart';
import 'package:sdrmobil/models/Malzeme/birim_cevrimi.dart';
import 'package:sdrmobil/models/Siparis/satis_grup_toplam.dart';
import 'package:sdrmobil/models/Siparis/siparis.dart';
import 'package:sdrmobil/models/Siparis/siparis_indrim.dart';
import 'package:sdrmobil/models/Siparis/siparis_satir_gruplu.dart';
import 'package:sdrmobil/models/Siparis/siparis_satir_list.dart';
import 'package:flutter/material.dart';
import 'package:sdrmobil/providers/db_provider.dart';

class KampanyaUygula2{
  KampanyaUygulanacaklar uygulanacakKampanyaAyarla(SiparisSatirList satirItem, String kampanyaadi, 
      int bedelsizkampanyaflag, int yuzdeselkampanyaflag, int kampanyaRsayac) {
      
      KampanyaUygulanacaklar kampanyaItem
         =KampanyaUygulanacaklar(
          aciklama: satirItem.aciklama,
          bazbirim: satirItem.bazbirim,
          bedelsizkampanyaflag: bedelsizkampanyaflag,
          birimfiyat: satirItem.birimfiyat,
          grupadi: satirItem.grupadi,
          grupadi1: satirItem.grupadi1,
          grupadi2: satirItem.grupadi2,
          grupadi3: satirItem.grupadi3,
          guid: satirItem.guid,
          indirim01flag: satirItem.indirim01flag,
          indirim02flag: satirItem.indirim02flag,
          indirim03flag: satirItem.indirim03flag,
          indirim04flag: satirItem.indirim04flag,
          indirim05flag: satirItem.indirim05flag,
          indirim06flag: satirItem.indirim06flag,
          iskontotutari1: satirItem.iskontotutari1,
          iskontotutari2: satirItem.iskontotutari2,
          iskontotutari3: satirItem.iskontotutari3,
          iskontotutari4: satirItem.iskontotutari4,
          iskontotutari5: satirItem.iskontotutari5,
          iskontotutari6: satirItem.iskontotutari6,
          kampanyaRsayac: kampanyaRsayac,
          kampanyaadi: kampanyaadi,
          kdvorani: satirItem.kdvorani,
          kdvtutari: satirItem.kdvtutari,
          malzemeadi: satirItem.malzemeadi,
          malzemekodu: satirItem.malzemekodu,
          miktar: satirItem.miktar,
          musrsayac: satirItem.musrsayac,
          path: satirItem.path,
          picture: satirItem.picture,
          rowNum: satirItem.rowNum,
          satirtutari: satirItem.satirtutari,
          siparissatirrsayac: satirItem.siparissatirrsayac,
          toplamindirim: satirItem.toplamindirim,
          tutar: satirItem.tutar,
          vadekodu: satirItem.vadekodu,
          yuzdeselkampanyaflag: yuzdeselkampanyaflag,
          secim: 0,
          bedelsizgruptoplammiktar: 0,
          satilacakmiktar: 0,
          grupkodu: "",
          kgrupAdi: "",
        );

      return kampanyaItem;

    }

  siparisIndirimiEkle(KampanyaUygulanacaklar item, double indirimYuzdesi, int indirimno, String indirimTipi, String kampanyaKodu)
  {
    final SiparisController _controller =Get.find();
    double indirimtutari=0;
    double indirimliTutar=0;

    double indirim01=0;    
    double indirim02=0;
    double indirim03=0;
    double indirim04=0;
    double indirim05=0;
    double indirim06=0;
    

    SiparisIndirim indirim;
    if (_controller.siparisIndirim.length>0)
    {      
      if (_controller.siparisIndirim.where((element) => element.sirano==item.rowNum).length>0)
        indirim=_controller.siparisIndirim.firstWhere((element) => element.sirano==item.rowNum);              
    }
    
    if (indirim!=null)
    {
      if (indirim.indirim01>0)
      {
        item.indirim01flag=1; item.iskontotutari1=indirim.indirim01;
      }
      if (indirimno==1) {item.indirim01flag=1; item.iskontotutari1=indirimYuzdesi; indirim.indirim01=indirimYuzdesi;}
      if (indirim.indirim02>0)
      {
        item.indirim02flag=1; item.iskontotutari2=indirim.indirim02;
      }
      if (indirimno==2) {item.indirim02flag=1; item.iskontotutari2=indirimYuzdesi; indirim.indirim02=indirimYuzdesi;}
      if (indirim.indirim03>0)
      {
        item.indirim03flag=1; item.iskontotutari3=indirim.indirim03;
      }
      if (indirimno==3) {item.indirim03flag=1; item.iskontotutari3=indirimYuzdesi; indirim.indirim03=indirimYuzdesi;}
      if (indirim.indirim04>0)
      {
        item.indirim04flag=1; item.iskontotutari4=indirim.indirim04;
      }
      if (indirimno==4) {item.indirim04flag=1; item.iskontotutari4=indirimYuzdesi; indirim.indirim04=indirimYuzdesi;}
      if (indirim.indirim05>0)
      {
        item.indirim05flag=1; item.iskontotutari5=indirim.indirim05;
      }
      if (indirimno==5) {item.indirim05flag=1; item.iskontotutari5=indirimYuzdesi; indirim.indirim05=indirimYuzdesi;}
      if (indirim.indirim06>0)
      {
        item.indirim06flag=1; item.iskontotutari6=indirim.indirim06;
      }
      if (indirimno==6) {item.indirim06flag=1; item.iskontotutari6=indirimYuzdesi; indirim.indirim06=indirimYuzdesi;}
    }
    
    indirimliTutar=item.tutar;
    for (var i = 1; i<=indirimno; i++) {
      if (i==1)
      {        
        if (i==indirimno) indirim01=indirimYuzdesi;
        if (item.indirim01flag==1 && item.iskontotutari1>0)
        {
          indirimtutari=(item.tutar * item.iskontotutari1)/100;
          indirimtutari=double.parse(indirimtutari.toStringAsFixed(2));
          indirimliTutar=indirimliTutar - indirimtutari;
        }
        else        
          if (item.iskontotutari1>0) indirimliTutar=indirimliTutar - item.iskontotutari1;
      }
      if (i==2)
      {
        if (i==indirimno) indirim02=indirimYuzdesi;
        if (item.indirim02flag==1 && item.iskontotutari2>0)
        {
          indirimtutari=(item.tutar * item.iskontotutari2)/100;
          indirimtutari=double.parse(indirimtutari.toStringAsFixed(2));
          indirimliTutar=indirimliTutar - indirimtutari;
        }
        else        
          if (item.iskontotutari2>0) indirimliTutar=indirimliTutar - item.iskontotutari2;
      }
      if (i==3)
      {
        if (i==indirimno) indirim03=indirimYuzdesi;
        if (item.indirim03flag==1 && item.iskontotutari3>0)
        {
          indirimtutari=(item.tutar * item.iskontotutari3)/100;
          indirimtutari=double.parse(indirimtutari.toStringAsFixed(2));
          indirimliTutar=indirimliTutar - indirimtutari;
        }
        else        
          if (item.iskontotutari3>0) indirimliTutar=indirimliTutar - item.iskontotutari3;
      }

      if (i==4)
      {
        if (i==indirimno) indirim04=indirimYuzdesi;
        if (item.indirim04flag==1 && item.iskontotutari4>0)
        {
          indirimtutari=(item.tutar * item.iskontotutari4)/100;
          indirimtutari=double.parse(indirimtutari.toStringAsFixed(2));
          indirimliTutar=indirimliTutar - indirimtutari;
        }
        else        
          if (item.iskontotutari4>0) indirimliTutar=indirimliTutar - item.iskontotutari4;
      }

      if (i==5)
      {
        if (i==indirimno) indirim05=indirimYuzdesi;
        if (item.indirim05flag==1 && item.iskontotutari5>0)
        {
          indirimtutari=(item.tutar * item.iskontotutari5)/100;
          indirimtutari=double.parse(indirimtutari.toStringAsFixed(2));
          indirimliTutar=indirimliTutar - indirimtutari;
        }
        else        
          if (item.iskontotutari5>0) indirimliTutar=indirimliTutar - item.iskontotutari5;
      }
      if (i==6)
      {
        if (i==indirimno) indirim06=indirimYuzdesi;
        if (item.indirim06flag==1 && item.iskontotutari6>0)
        {
          indirimtutari=(item.tutar * item.iskontotutari6)/100;
          indirimtutari=double.parse(indirimtutari.toStringAsFixed(2));
          indirimliTutar=indirimliTutar - indirimtutari;
        }
        else        
          if (item.iskontotutari6>0) indirimliTutar=indirimliTutar - item.iskontotutari6;
      }
    }

    if (indirim!=null)
    {
      _controller.siparisIndirim.forEach((element) { 
        if (element.sirano==item.rowNum)
        {
          element.indirim01=indirim.indirim01;
          element.indirim02=indirim.indirim02;
          element.indirim03=indirim.indirim03;
          element.indirim04=indirim.indirim04;
          element.indirim05=indirim.indirim05;
          element.indirim06=indirim.indirim06;
          element.indirimyuzdesi=indirimYuzdesi;
          element.indirimtutari=indirimtutari;
        }
      });
    }
    else
    {
      SiparisIndirim siparisIndirim= new SiparisIndirim(grupkodu: item.grupkodu,
                            indirim01: indirim01,
                            indirimyuzdesi: indirimYuzdesi,
                            indirim02: indirim02,
                            indirim03: indirim03,
                            indirim04: indirim04,
                            indirim05: indirim05,
                            indirim06: indirim06,
                            siparissatirrsayac: _controller.siparissatirrsayac.value,
                            siparisrsayac: _controller.siparissayac.value,
                            satilan: item.miktar,
                            indirimtutari: indirimtutari,                                      
                            sirano: item.rowNum,
                            indirimkodu: kampanyaKodu,
                            indirimtipi: indirimTipi);
      _controller.siparisIndirim.add(siparisIndirim);
    }

    
  }

  siparisIndirimSonMiktarlari(SiparisIndirim indirim, KampanyaUygulanacaklar item, BuildContext context)
  {
    if (indirim.indirim01>0)
      {siparisIndirimiEkle(item, indirim.indirimyuzdesi, 1, indirim.indirimtipi, indirim.indirimkodu);}
    if (indirim.indirim02>0)
      {siparisIndirimiEkle(item, indirim.indirimyuzdesi, 2, indirim.indirimtipi, indirim.indirimkodu);}
    if (indirim.indirim03>0)
      {siparisIndirimiEkle(item, indirim.indirimyuzdesi, 3, indirim.indirimtipi, indirim.indirimkodu);}
    if (indirim.indirim04>0)
      {siparisIndirimiEkle(item, indirim.indirimyuzdesi, 4, indirim.indirimtipi, indirim.indirimkodu);}
    if (indirim.indirim05>0)
      {siparisIndirimiEkle(item, indirim.indirimyuzdesi, 5, indirim.indirimtipi, indirim.indirimkodu);}
    if (indirim.indirim06>0)
      {siparisIndirimiEkle(item, indirim.indirimyuzdesi, 6, indirim.indirimtipi, indirim.indirimkodu);}    
  }
  
  Future<bool> bedelsizVerilen(int siparissayac, KampanyaBedelsizVerilen verilen, KampanyaUygulanacaklar item, int iskontohanesi, String kampanyaKodu, BuildContext context) async{
  final SiparisController _controller =Get.find();
  final Controller mainController =Get.find();
  Locale myLocale = Localizations.localeOf(context);
    final mFormat = new NumberFormat.currency(locale: myLocale.languageCode,
      name: "MoneyFormat",symbol: "", decimalDigits: 2);

    item.musrsayac=siparissayac;
    item.guid=_controller.sGuid.value;
    item.malzemekodu=verilen.malzemeKodu;
    item.malzemeadi=_controller.secilenUrun.malzemeadi;                  
    item.bazbirim=verilen.birim;
    item.birimfiyat=verilen.birimfiyat;
    item.miktar=verilen.miktar;
    item.tutar=verilen.miktar * verilen.birimfiyat;
    item.kdvorani=_controller.secilenUrun.kdvorani;
    item.kdvtutari=0;                  
    item.satirtutari=0;
    item.siparissatirrsayac=0;
    item.aciklama="Mobil Kampanya Bedelsiz Verilen";
    if (iskontohanesi==null) iskontohanesi=0;

    if (iskontohanesi>0)
    {
      item.indirim01flag=0;
      item.indirim02flag=0;
      item.indirim03flag=0;
      item.indirim04flag=0;
      item.indirim05flag=0;
      item.indirim06flag=0;

      item.iskontotutari1=0;
      item.iskontotutari2=0;
      item.iskontotutari3=0;
      item.iskontotutari4=0;               
      item.iskontotutari5=0;
      item.iskontotutari6=0;      
    }
    else
    {
      if (_controller.secilenUrun!=null)
      {
        if (_controller.secilenUrun.iskontotutari6>0) item.bedelsiztpr=_controller.secilenUrun.iskontotutari6.toString();
        if (_controller.secilenUrun.iskontotutari5>0) item.bedelsiztpr=_controller.secilenUrun.iskontotutari5.toString();
        if (_controller.secilenUrun.iskontotutari4>0) item.bedelsiztpr=_controller.secilenUrun.iskontotutari4.toString();
        if (_controller.secilenUrun.iskontotutari3>0) item.bedelsiztpr=_controller.secilenUrun.iskontotutari3.toString();
        if (_controller.secilenUrun.iskontotutari2>0) item.bedelsiztpr=_controller.secilenUrun.iskontotutari2.toString();
        if (_controller.secilenUrun.iskontotutari1>0) item.bedelsiztpr=_controller.secilenUrun.iskontotutari1.toString();
      }
    }
    
    item.toplamindirim=0;
    _controller.setIskonto(item.iskontotutari1.toString(), 1,context);
    _controller.setIskonto(item.iskontotutari2.toString(), 2,context);
    _controller.setIskonto(item.iskontotutari3.toString(), 3,context);
    _controller.setIskonto(item.iskontotutari4.toString(), 4,context);
    _controller.setIskonto(item.iskontotutari5.toString(), 5,context);
    _controller.setIskonto(item.iskontotutari6.toString(), 6,context);

    String resultfiyat=item.birimfiyat.toString();
    if (mainController.birimFiyatRakamSayisi.value>0)
    {
      final bFormat = new NumberFormat.currency(locale: myLocale.languageCode,
        name: "",symbol: "", decimalDigits: mainController.birimFiyatRakamSayisi.value);
      resultfiyat=bFormat.format(item.birimfiyat);
    }
    else
    {
      resultfiyat=mFormat.format(item.birimfiyat);
    }
    
    _controller.cfiyat.text=resultfiyat;
    _controller.cbirim.text=item.bazbirim;
    _controller.siparisBirimi.value=item.bazbirim;
    _controller.cmiktar.text=_controller.getTutar(item.miktar.toString(), context);
    _controller.ctutar.text=_controller.getTutar(item.tutar.toString(), context);
    _controller.cindirimlitutar.text="0";
    _controller.ctoplamtutar.text="0";                                     
    _controller.siparissatirrsayac.value=0;
    _controller.update();
    
    //iskontohanesi 0 veya null olabilir.    
    int indirimhanesi=iskontohanesi;
    if (iskontohanesi==0)
    {
      await _controller.tutarHesapla(context);

      item.iskontotutari1=item.iskontotutari1==null ? 0:item.iskontotutari1;
      item.iskontotutari2=item.iskontotutari2==null ? 0:item.iskontotutari2;
      item.iskontotutari3=item.iskontotutari3==null ? 0:item.iskontotutari3;
      item.iskontotutari4=item.iskontotutari4==null ? 0:item.iskontotutari4;
      item.iskontotutari5=item.iskontotutari5==null ? 0:item.iskontotutari5;
      item.iskontotutari6=item.iskontotutari6==null ? 0:item.iskontotutari6;

      indirimhanesi=item.iskontotutari1==0 ? 1:indirimhanesi;
      indirimhanesi=item.iskontotutari2==0 ? 2:indirimhanesi;
      indirimhanesi=item.iskontotutari3==0 ? 3:indirimhanesi;
      indirimhanesi=item.iskontotutari4==0 ? 4:indirimhanesi;
      indirimhanesi=item.iskontotutari5==0 ? 5:indirimhanesi;
      indirimhanesi=item.iskontotutari6==0 ? 6:indirimhanesi;
    }
    
    switch (iskontohanesi) {
        case 0:
          if (!await KampanyaUygula().yuzdeselKampanyaUygula(item, 1, 100, indirimhanesi, context))
          { 
            snackbar("Uyarı", "Yüzdesel indirim,${item.rowNum} nolu satır için uygulanamadı.", Icons.error);
            return false;
          }
          siparisIndirimiEkle(item, 100, indirimhanesi,'B', kampanyaKodu);
          break;
        case 1:
          if (!await KampanyaUygula().yuzdeselKampanyaUygula(item, 1, 100, indirimhanesi, context))
          {                  
            snackbar("Uyarı", "Yüzdesel indirim,${item.rowNum} nolu satır için uygulanamadı.", Icons.error);
            return false;
          }
          siparisIndirimiEkle(item, 100, indirimhanesi,'B', kampanyaKodu);
          break;
        case 2:
          if (!await KampanyaUygula().yuzdeselKampanyaUygula(item, 1, 100, indirimhanesi, context))
          {                  
            snackbar("Uyarı", "Bedelsiz indirim uygulanamadı.", Icons.error);
            return false;
          }
          siparisIndirimiEkle(item, 100, indirimhanesi,'B', kampanyaKodu);          
          break;
        case 3:
          if (!await KampanyaUygula().yuzdeselKampanyaUygula(item, 1, 100, indirimhanesi, context))
          {                  
            snackbar("Uyarı", "Bedelsiz indirim uygulanamadı.", Icons.error);
            return false;
          }
          siparisIndirimiEkle(item, 100, indirimhanesi,'B', kampanyaKodu);
          break;
        case 4:
          if (!await KampanyaUygula().yuzdeselKampanyaUygula(item, 1, 100, indirimhanesi, context))
          {                  
            snackbar("Uyarı", "Bedelsiz indirim uygulanamadı.",Icons.error);
            return false;
          }
          siparisIndirimiEkle(item, 100, indirimhanesi,'B', kampanyaKodu);
          break;
        case 5:
          if (!await KampanyaUygula().yuzdeselKampanyaUygula(item, 1, 100, indirimhanesi, context))
          {                  
            snackbar("Uyarı", "Bedelsiz indirim uygulanamadı.",Icons.error);
            return false;
          }
          siparisIndirimiEkle(item, 100, indirimhanesi,'B', kampanyaKodu);
          break;
        case 6:
          if (!await KampanyaUygula().yuzdeselKampanyaUygula(item, 1, 100, indirimhanesi, context))
          {                  
            snackbar("Uyarı", "Bedelsiz indirim uygulanamadı.",Icons.error);
            return false;
          }
          siparisIndirimiEkle(item, 100, indirimhanesi,'B', kampanyaKodu);          
          break;
        default:
          break;
      }

    return true;

  }

  bedelsizKampanyaUygula(int mussayac, BuildContext context) async
  {
    //Bedelsiz Kampanya başlangıcı
      List<SiparisSatirGruplu> siparisSatirGruplu =await DBProvider.db.getSiparisListGruplu();
      List<KampanyaBedelsizSatir> bedelsiz =await DBProvider.db.getKampanyaBedelsizSatir(mussayac);
      Siparis siparis=await DBProvider.db.getSiparis(mussayac);           
      final SiparisController _controller =Get.find();

      List<SiparisSatirGruplu> satirToplam=<SiparisSatirGruplu>[];
      List<SatisGrupToplam> satisGrupToplamList=<SatisGrupToplam>[];
      int rowNum=0; 
      
      //İskonto hanesi sıfır ise boş olan satıra atıyor.
      if (bedelsiz.length>0)
      {
        await Future.forEach(bedelsiz, (KampanyaBedelsizSatir element) async{
          //bedelsiz.forEach((element) async { 
          List<SiparisSatirGruplu> satir=siparisSatirGruplu.where((item) => item.malzemekodu==element.malzemeKodu).toList();

          await Future.forEach(satir, (item) async
          {           
            if (item.birimi.toString().toLowerCase().trim()!=element.birim.toString().toLowerCase().trim())
            {
            BirimCevrimi birimCevrimi= await DBProvider.db.getBirimCevrimiBirimli(item.malzemekodu, item.birimi, element.birim);
            if (birimCevrimi.rsayac>0)
            {
              item.miktar=(birimCevrimi.bolunen * item.miktar)/birimCevrimi.bolen;
            }
            }

            SiparisSatirGruplu satirToplamItem;
            double toplamMikar=item.miktar;

            if (satirToplam.length>0)
            {
              if (satirToplam.where((item1) => item1.malzemekodu==item.malzemekodu 
                                      && item1.kampanyaRsayac==element.kampanyaRsayac).length>0)
              {
                satirToplamItem=satirToplam.firstWhere((item1) => item1.malzemekodu==item.malzemekodu 
                                      && item1.kampanyaRsayac==element.kampanyaRsayac);
                if (item.miktar>0)
                {
                  toplamMikar=satirToplamItem.miktar + item.miktar;                
                }
                satirToplam.remove(satirToplamItem);
              }            
            }          
          
          satirToplam.add(
            new SiparisSatirGruplu(
              birimi: item.birimi,
              malzemekodu: item.malzemekodu,
              miktar: toplamMikar,
              kampanyaRsayac: element.kampanyaRsayac,
              kampanyaadi: element.kampanyaadi,
              grupAdi: element.grupAdi
            )
          );
          

          //Satis Grup Toplam Alınıyor.
          SatisGrupToplam satisGrupToplam;
          double toplamMiktar=item.miktar;

          if (satisGrupToplamList.length>0)
          {
            if (satisGrupToplamList.where((item1) => 
              item1.grupkodu==element.grupKodu && item1.kampanyaRsayac==element.kampanyaRsayac).length>0)
            {
              satisGrupToplam=satisGrupToplamList.firstWhere((item1) => 
              item1.grupkodu==element.grupKodu && item1.kampanyaRsayac==element.kampanyaRsayac);
              if (item.miktar>0)
              {
                toplamMiktar=satisGrupToplam.miktar + item.miktar;                
              }
              satisGrupToplamList.remove(satisGrupToplam);
            }            
          }
          
          
          

          if (item.miktar>0)
          {
            satisGrupToplamList.add(
              new SatisGrupToplam(
                grupkodu: element.grupKodu,
                miktar: toplamMiktar,
                gruptoplammiktar: element.gruptoplammiktar,
                bedelsizgruptoplammiktar: element.bedelsizgruptoplammiktar,
                kampanyaRsayac: element.kampanyaRsayac,
                iskontohanesi: element.iskontohanesi,
                kampanyaadi: element.kampanyaadi,  
                grupAdi: element.grupAdi              
              )
            );
          }

        });        
      });

      }
      
      if (satisGrupToplamList.length>0)
      {
        
        await Future.forEach(satisGrupToplamList, (SatisGrupToplam a) async{

        if (a.miktar>0 && a.miktar>=a.gruptoplammiktar) 
        { 
          List<KampanyaBedelsizVerilen> bedelsizverilen=await DBProvider.db.getKampanyaBedelsizVerilen(a.kampanyaRsayac);

          int verilecekMiktarkati=0;
          verilecekMiktarkati=int.parse((a.miktar/a.gruptoplammiktar).toStringAsFixed(0));
          if (verilecekMiktarkati>0 && a.iskontohanesi>0)
          {
                        
            if (bedelsizverilen.length>0)
            {
                            
              await Future.forEach(bedelsizverilen, (KampanyaBedelsizVerilen verilen) async               
              {
                //KampanyaBedelsizVerilen verilen=bedelsizverilen.first;
                if (verilen.birimfiyat>0)
                {
                  if (verilen.miktar>0)
                  {
                    
                    _controller.secilenUrun=_controller.malzemeDetay.firstWhere((ver) => ver.malzemekodu==verilen.malzemeKodu);

                    SiparisSatirList item=new SiparisSatirList();
                    _controller.sGuid.value=siparis.guid;

                    KampanyaUygulanacaklar kampItemUygulanacak=uygulanacakKampanyaAyarla(item, a.kampanyaadi,1,0, a.kampanyaRsayac);
                    rowNum=rowNum + 1;
                    kampItemUygulanacak.rowNum=rowNum;

                    await bedelsizVerilen(mussayac, verilen, kampItemUygulanacak, a.iskontohanesi, verilen.kampanyaKodu,context);                    
                    if (kampItemUygulanacak!=null)
                    {
                      kampItemUygulanacak.satilacakmiktar=verilecekMiktarkati * verilen.miktar;
                      kampItemUygulanacak.bedelsizgruptoplammiktar=verilecekMiktarkati * a.bedelsizgruptoplammiktar;
                      kampItemUygulanacak.grupkodu=a.grupkodu;
                      kampItemUygulanacak.kgrupAdi=a.grupAdi;
                      kampItemUygulanacak.miktar=verilecekMiktarkati * verilen.miktar;
                      kampItemUygulanacak.zorunlu=verilen.zorunlu;
                      if (verilen.zorunlu==1) kampItemUygulanacak.secim=1;                      
                    }                   
                    _controller.uygulanacakKampanyalar.add(kampItemUygulanacak);
                    _controller.update();
                    // bool kaydet=await SiparisVeriIslemleri().siparisKaydet();
                    // if (kaydet) snackbar('Bilgi', 'Siparişe bedelsiz kampanya başarıyla uygulandı.',null);
                  }
                  else
                  {
                    //kolonlar KampanyaUygulanacaklar listesine eklenecek.
                    verilen.miktar= verilecekMiktarkati * verilen.miktar;
                    _controller.secilenUrun=_controller.malzemeDetay.firstWhere((ver) => ver.malzemekodu==verilen.malzemeKodu);

                    SiparisSatirList item=new SiparisSatirList();
                    _controller.sGuid.value=siparis.guid;

                    KampanyaUygulanacaklar kampItemUygulanacak=uygulanacakKampanyaAyarla(item, a.kampanyaadi,1,0, a.kampanyaRsayac);
                    rowNum=rowNum + 1;
                    kampItemUygulanacak.rowNum=rowNum;

                    await bedelsizVerilen(mussayac, verilen, kampItemUygulanacak, a.iskontohanesi, verilen.kampanyaKodu, context);

                    if (kampItemUygulanacak!=null)
                    {
                      kampItemUygulanacak.satilacakmiktar=verilecekMiktarkati * verilen.miktar;
                      kampItemUygulanacak.bedelsizgruptoplammiktar=verilecekMiktarkati * a.bedelsizgruptoplammiktar;
                      kampItemUygulanacak.grupkodu=a.grupkodu;
                      kampItemUygulanacak.kgrupAdi=a.grupAdi;
                      kampItemUygulanacak.miktar=verilecekMiktarkati * verilen.miktar;
                      kampItemUygulanacak.zorunlu=verilen.zorunlu;
                      if (verilen.zorunlu==1) kampItemUygulanacak.secim=1;
                      
                    }                   

                    _controller.uygulanacakKampanyalar.add(kampItemUygulanacak);
                    _controller.update();

                    

                  }

                }
              });
            }
          }                      
        }          
      });
      }
      
      //Satır Toplamı ile bedelsiz şartı karşılaştırılıyor.
      if (bedelsiz.where((b) => b.miktarSarti>0 && b.gruptoplammiktar==0).length>0)
      {
        await Future.forEach(bedelsiz.where((b) => b.miktarSarti>0 && b.gruptoplammiktar==0), (KampanyaBedelsizSatir element) async {
        //bedelsiz.where((b) => b.miktarSarti>0 && b.gruptoplammiktar==0).forEach((element) async {

          await Future.forEach(satirToplam, (SiparisSatirGruplu satirItem) async {
          //satirToplam.forEach((satirItem) async { 
          if (element.malzemeKodu==satirItem.malzemekodu)
          {            
            int verilecekMiktarkati=0;            
            if (element.miktarSarti<=satirItem.miktar)
            {
              verilecekMiktarkati=int.parse((satirItem.miktar/element.miktarSarti).toStringAsFixed(0));                
            }                        
            if (verilecekMiktarkati>0)
            {
              List<KampanyaBedelsizVerilen> bedelsizverilen=await DBProvider.db.getKampanyaBedelsizVerilen(element.kampanyaRsayac);
              if (bedelsizverilen.length==1)
              {

                KampanyaBedelsizVerilen verilen=bedelsizverilen.first;
                if (verilen.birimfiyat>0)
                {
                  if (verilen.miktar>0)
                  {
                    verilen.miktar= verilecekMiktarkati * verilen.miktar;
                    _controller.secilenUrun=_controller.malzemeDetay.firstWhere((ver) => ver.malzemekodu==verilen.malzemeKodu);

                    SiparisSatirList item=new SiparisSatirList();
                    _controller.sGuid.value=siparis.guid;

                    KampanyaUygulanacaklar kampItemUygulanacak = 
                    uygulanacakKampanyaAyarla(item, element.kampanyaadi,1,0, element.kampanyaRsayac);
                    if (kampItemUygulanacak!=null)
                    {
                      kampItemUygulanacak.satilacakmiktar=verilecekMiktarkati * verilen.miktar;
                      kampItemUygulanacak.bedelsizgruptoplammiktar=verilecekMiktarkati * element.bedelsizgruptoplammiktar;
                      kampItemUygulanacak.grupkodu=element.grupKodu;
                      kampItemUygulanacak.kgrupAdi=element.grupAdi;
                      kampItemUygulanacak.miktar=verilecekMiktarkati * verilen.miktar;
                      kampItemUygulanacak.zorunlu=verilen.zorunlu;
                      if (verilen.zorunlu==1) kampItemUygulanacak.secim=1;

                    }
                    rowNum=rowNum + 1;
                    kampItemUygulanacak.rowNum=rowNum;

                    if (await bedelsizVerilen(mussayac, verilen, kampItemUygulanacak, element.iskontohanesi, verilen.kampanyaKodu, context))
                    {                      
                      _controller.uygulanacakKampanyalar.add(kampItemUygulanacak);
                      _controller.update();                      
                      // bool kaydet=await SiparisVeriIslemleri().siparisKaydet();
                      // if (kaydet) snackbar('Bilgi', 'Siparişe bedelsiz kampanya başarıyla uygulandı.',null);
                    }

                  }
                  else
                  {
                    //Bu kısımda kullanıcının miktar girmesi için pencere açılacak. 
                    verilen.miktar= verilecekMiktarkati * verilen.miktar;
                    _controller.secilenUrun=_controller.malzemeDetay.firstWhere((ver) => ver.malzemekodu==verilen.malzemeKodu);

                    SiparisSatirList item=new SiparisSatirList();
                    _controller.sGuid.value=siparis.guid;

                    KampanyaUygulanacaklar kampItemUygulanacak = 
                    uygulanacakKampanyaAyarla(item, element.kampanyaadi,1,0, element.kampanyaRsayac);

                    if (kampItemUygulanacak!=null)
                    {
                      kampItemUygulanacak.satilacakmiktar=verilecekMiktarkati * verilen.miktar;
                      kampItemUygulanacak.bedelsizgruptoplammiktar=verilecekMiktarkati * element.bedelsizgruptoplammiktar;
                      kampItemUygulanacak.grupkodu=element.grupKodu;
                      kampItemUygulanacak.kgrupAdi=element.grupAdi;
                      kampItemUygulanacak.miktar=verilecekMiktarkati * verilen.miktar;
                      kampItemUygulanacak.zorunlu=verilen.zorunlu;
                      if (verilen.zorunlu==1) kampItemUygulanacak.secim=1;                      
                    }
                    rowNum=rowNum + 1;
                    kampItemUygulanacak.rowNum=rowNum;

                    if (await bedelsizVerilen(mussayac, verilen, kampItemUygulanacak, element.iskontohanesi, verilen.kampanyaKodu, context))
                    {                      
                      _controller.uygulanacakKampanyalar.add(kampItemUygulanacak);
                      _controller.update();
                    }
                    
                  }
                }

              }             
              
            }
          }
        });
        });
      }
      
      //bedelsiz Kampanya bitişi
  }


  Future<bool> kampanyaGeriAl(int siparisrsayac, BuildContext context) async {
    final SiparisController _controller =Get.find();
    List<SiparisIndirim> indirimler=<SiparisIndirim>[];

    indirimler = await DBProvider.db.getSiparisIndirim(siparisrsayac);

    if (indirimler.length>0)
    {
      await Future.forEach(indirimler, (SiparisIndirim item) async {
        if (item.indirimtipi=="B")
        {
          if (item.siparissatirrsayac>0)
          {
            int a=await DBProvider.db.deleteSiparisSatir(item.siparissatirrsayac);
            if (a==0) return false;            
          }
        }
        if (item.indirimtipi=="Y")
        {
          SiparisSatirList satirItem=await DBProvider.db.getSiparisSatirList(item.siparissatirrsayac);

          _controller.secilenUrun=_controller.malzemeDetay.firstWhere((element) => element.malzemekodu==satirItem.malzemekodu);

          satirItem.indirim01flag=_controller.secilenUrun.indirim01flag;
          satirItem.indirim02flag=_controller.secilenUrun.indirim02flag;
          satirItem.indirim03flag=_controller.secilenUrun.indirim03flag;
          satirItem.indirim04flag=_controller.secilenUrun.indirim04flag;
          satirItem.indirim05flag=_controller.secilenUrun.indirim05flag;
          satirItem.indirim06flag=_controller.secilenUrun.indirim06flag;

          satirItem.iskontotutari1=_controller.secilenUrun.iskontotutari1;          
          satirItem.iskontotutari2=_controller.secilenUrun.iskontotutari2;          
          satirItem.iskontotutari3=_controller.secilenUrun.iskontotutari3;
          satirItem.iskontotutari4=_controller.secilenUrun.iskontotutari4;          
          satirItem.iskontotutari5=_controller.secilenUrun.iskontotutari5;
          satirItem.iskontotutari6=_controller.secilenUrun.iskontotutari6;
          

          _controller.siparissayac.value=satirItem.musrsayac;
          _controller.siparissatirrsayac.value=satirItem.siparissatirrsayac;          
          _controller.getSiparisSatirDegerleriSatirList(satirItem, context);
          await _controller.tutarHesapla(context);
          bool kaydet=await SiparisVeriIslemleri().siparisKaydet(context);
          if (!kaydet)
          {
            snackbar("Uyarı", "Kampanya geri alınırken kayıt silme işlemi yapılamadı.", Icons.error);            
            return false;
          }
          if (!await DBProvider.db.deleteSiparisIndirim(item.siparissatirrsayac, item.indirimkodu, item.grupkodu))
          {
            snackbar("Uyarı", "Kampanya geri alınırken kayıt silme işlemi yapılamadı.", Icons.error);
            return false;
          }

        }
      });

    }

    return true;
  }

  Future<bool> otomatikKampanyaUygula(BuildContext context) async {
    final SiparisController _controller =Get.find();
    bool result=true;

    if (_controller.uygulanacakKampanyalar!=null)
    {
        List<SiparisIndirim> siparisIndirim=<SiparisIndirim>[];
        if (_controller.siparisIndirim.length>0)
        {
          _controller.siparisIndirim.forEach((element) {
            siparisIndirim.add(element);
          });                

          _controller.siparisIndirim.clear();
        }

        if (_controller.uygulanacakKampanyalar.length>0)
        {
          await Future.forEach(_controller.uygulanacakKampanyalar, (KampanyaUygulanacaklar item) async               
          {
            _controller.bedelsizkampanyaflag.value=0;
            _controller.yuzdeselkampanyaflag.value=0;
            _controller.secilenUrun=_controller.malzemeDetay.firstWhere((m) => m.malzemekodu==item.malzemekodu);

            if (item.yuzdeselkampanyaflag==1 && item.secim==1)
            {
              _controller.bedelsizkampanyaflag.value=0;
              _controller.yuzdeselkampanyaflag.value=1;                  
              _controller.getSiparisSatirDegerleri(item, context);
              _controller.siparissatirrsayac.value=item.siparissatirrsayac;                  
              _controller.siparissayac.value=item.musrsayac;              
              result=await _controller.tutarHesapla(context);
              result=await SiparisVeriIslemleri().siparisKaydet(context);

              if (siparisIndirim.length>0)
              {
                SiparisIndirim indirim=siparisIndirim.firstWhere((element) => element.sirano==item.rowNum);
                if (indirim!=null)
                  siparisIndirimSonMiktarlari(indirim, item, context);
              }

              result=await SiparisVeriIslemleri().siparisIndirimKaydet(item.rowNum);
              if (!result) return result;
            }               

            if (item.bedelsizkampanyaflag==1 && item.satilacakmiktar>0 && item.secim==1)
            { 
              _controller.bedelsizkampanyaflag.value=1;
              _controller.yuzdeselkampanyaflag.value=0;
              item.miktar=item.satilacakmiktar;

              //Miktar değiştiği için değerler yeniden alınıp Hesaplanıyor.
              if (item.iskontotutari1!=100 || item.indirim01flag!=1)
              { item.iskontotutari1=_controller.secilenUrun.iskontotutari1; item.indirim01flag=_controller.secilenUrun.indirim01flag;
                if (item.iskontotutari2!=100 || item.indirim02flag!=1)
                { item.iskontotutari2=_controller.secilenUrun.iskontotutari2; item.indirim02flag=_controller.secilenUrun.indirim02flag;
                  if (item.iskontotutari3!=100 || item.indirim03flag!=1)
                  { item.iskontotutari3=_controller.secilenUrun.iskontotutari3; item.indirim03flag=_controller.secilenUrun.indirim03flag;
                    if (item.iskontotutari4!=100 || item.indirim04flag!=1)
                    { item.iskontotutari4=_controller.secilenUrun.iskontotutari4; item.indirim04flag=_controller.secilenUrun.indirim04flag;
                      if (item.iskontotutari5!=100 || item.indirim05flag!=1)
                      { item.iskontotutari5=_controller.secilenUrun.iskontotutari5; item.indirim05flag=_controller.secilenUrun.indirim05flag;
                        if (item.iskontotutari6!=100 || item.indirim06flag!=1)
                        { item.iskontotutari6=_controller.secilenUrun.iskontotutari6; item.indirim06flag=_controller.secilenUrun.indirim06flag;}
                      }
                    }
                  }
                }
              }                                          

              _controller.getSiparisSatirDegerleri(item, context);
              _controller.siparissatirrsayac.value=0;
              _controller.siparissayac.value=item.musrsayac;                  

              result=await _controller.tutarHesapla(context);
              if (!result) return result;

              // if (siparisIndirim.length>0)
              // {
              //   //yeni hesaplanan değerler indirim satırına ekleniyor.
              //   SiparisIndirim indirim=siparisIndirim.firstWhere((element) => element.sirano==item.rowNum);
              //   if (indirim!=null)
              //     siparisIndirimSonMiktarlari(indirim, item, context);
              // }
                           
              await SiparisVeriIslemleri().siparisKaydet(context);
              _controller.bedelsizptr.value="";

              if (_controller.siparissatirrsayac.value>0)
              {
                _controller.siparisIndirim.where((s) => s.sirano==item.rowNum).forEach((element) { 
                  element.siparisrsayac=item.musrsayac;
                  element.siparissatirrsayac=_controller.siparissatirrsayac.value;
                });                    
              }

              result=await SiparisVeriIslemleri().siparisIndirimKaydet(item.rowNum);
              if (!result) return result;
            }

          });
        _controller.bedelsizptr.value="";
        _controller.bedelsizkampanyaflag.value=0;
        _controller.yuzdeselkampanyaflag.value=0;
        _controller.siparissatirrsayac.value=0;
                    
        }
    }

    return result;
  }


}