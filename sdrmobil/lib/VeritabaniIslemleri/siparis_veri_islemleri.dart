
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sdrmobil/components/get_snackbar.dart';
import 'package:sdrmobil/controller/controller.dart';
import 'package:sdrmobil/controller/siparis_controller.dart';
import 'package:sdrmobil/models/Satis/satis_tipi.dart';
import 'package:sdrmobil/models/Siparis/siparis.dart';
import 'package:sdrmobil/models/Siparis/siparis_indrim.dart';
import 'package:sdrmobil/models/Siparis/siparis_satir.dart';
import 'package:sdrmobil/models/Siparis/siparis_satir_toplam.dart';
import 'package:sdrmobil/providers/db_provider.dart';
class SiparisVeriIslemleri {
  Future<bool> siparisKaydet(BuildContext context) async {
    final SiparisController _controller =Get.put(SiparisController());
    Controller mainController = Get.find();
    
    String uyariMesaji="";

      if (mainController.temsilcikodu.value == "" || mainController.temsilcikodu.value == null) {
        uyariMesaji="Temsilci bulunasmadı, sisteme yeniden giriş yapmalısınız.";
        snackbar("Uyarı", uyariMesaji, Icons.person);
        return false;
      }
      if (mainController.carikod.value == "" || mainController.carikod.value == null) {
        uyariMesaji="Ziyaret başlatılmamış,önce ziyaret başlatmalısınız.";
        snackbar("Uyarı", uyariMesaji, Icons.person);
        return false;
      }
      if (_controller.satisTipikodu.toString() == "" || _controller.satisTipikodu.toString() == null) {
        uyariMesaji=uyariMesaji + "Satış tipi seçmelisiniz.";
      }

      if (_controller.siparisTipi.toString() == "" || _controller.siparisTipi.toString() == null) {
        uyariMesaji=uyariMesaji + "Sipariş tipi seçmelisiniz.";                      
      }
      if (_controller.siparisTarihiController.text == "" || _controller.siparisTarihiController.text == null) {
        uyariMesaji=uyariMesaji + "Sipariş tarihi girmelisiniz.";
      }
      if (_controller.sevkTarihiController.text == "" || _controller.sevkTarihiController.text == null) {
        uyariMesaji=uyariMesaji + "Sevk tarihi girmelisiniz.";
      }      

      double tutar=double.parse(_controller.setTutar(_controller.cfiyat.text, context));
      if (tutar==0){
        uyariMesaji=uyariMesaji + "Ürün fiyatı girilmemiş.";
      }
      double miktar=double.parse(_controller.setTutar(_controller.cmiktar.text, context));
      if (miktar==0){
        uyariMesaji=uyariMesaji + "Ürün miktarı girilmemiş.";
      }

      if (uyariMesaji!="")
      {        
        //snackbar("Hata", uyariMesaji, );
        snackbar("Hata", uyariMesaji, Icons.person);
        return false;
      }


      SatisTipi satisTipi= await DBProvider.db.getSatisTipiParametreleri(_controller.satisTipikodu.value);
      String sGuid;
      if (_controller.sGuid.value=="" || _controller.sGuid.value==null)
        sGuid=await DBProvider.db.getNewId();
      else
        sGuid=_controller.sGuid.value;

      double siparistutari=_controller.tutar.value;
      double indirimtutari=_controller.indirimTutari.value;
      double toplamkdv=_controller.kdvTutari.value;
      double toplamtutar=_controller.toplamaTutar.value;      
      

      int sirano=0;
      if (_controller.siparissayac.value>0)
      {
        SiparisSatirToplam siparisSatirToplam= await DBProvider.db.getSiparisSatirToplam(_controller.siparissayac.value, _controller.siparissatirrsayac.value);
        sirano= siparisSatirToplam.sirano==null ? 1:siparisSatirToplam.sirano;
        siparistutari=siparistutari + (siparisSatirToplam.tutar==null ? 0:siparisSatirToplam.tutar);
        indirimtutari=indirimtutari + (siparisSatirToplam.indirimTutari==null ? 0:siparisSatirToplam.indirimTutari);
        toplamkdv= toplamkdv + (siparisSatirToplam.kdvTutari==null ? 0:siparisSatirToplam.kdvTutari);
        toplamtutar=toplamtutar + (siparisSatirToplam.toplamaTutar==null ? 0:siparisSatirToplam.toplamaTutar);
      }
      else
      {
        sirano=1;
      }
      
      try 
      {
        int ziyaretId=0;
        if (mainController.uzaksiparis.value==1 || mainController.musteriKarti.value==1)
          ziyaretId=mainController.uzakIslemziyaretId.value;
        else 
          ziyaretId=mainController.ziyaretId.value;

        
        Siparis siparis=
          Siparis(cid: 'JOT',             
            musterino: mainController.carikod.value,
            teslimmusterino: mainController.carikod.value,
            //siparistarihi:DateFormat("yyyy-MM-dd hh:mm:ss").parse(DateTime.now().toString()),            
            siparistarihi:DateFormat('dd-MM-yyyy').parse(_controller.siparisTarihiController.text),

            siparisasama:"1",
            satistipi:_controller.satisTipikodu.value,
            siparisno:0,
            parabirimi:"TRL",
            satistemsilcisi:mainController.temsilcikodu.value,
            siparistutari:siparistutari, 
            toplamtutar:toplamtutar, 
            indirimtutari:indirimtutari, 
            onay:_controller.siparisOnay.value,
            toplamkdv:toplamkdv, 
            sonversiyon:1,
            toplamotv:0,
            subfaturatipiid:"01",
            tesisno:satisTipi.tesisno,
            depono:satisTipi.depono,
            siparisfirma:"02", //kontrol edilecek.
            aktarimtipi:"2-Dizüstünden",
            kullanici:"Admin",
            stoktipino:satisTipi.stoktipino,
            sevktarihi:DateFormat('dd-MM-yyyy').parse(_controller.sevkTarihiController.text),
            returnsayac:0,
            subekodu:_controller.subekodu.value,
            adrestanimikod2:"",
            adrestanimi:"",
            androidgpssayac:ziyaretId,
            aciklama:"",
            siparisformaciklama:_controller.aciklamaController.text,
            aciklamaandroid:"",
            guid:sGuid
          );

          String indirimler="";
          String indirim01= _controller.setTutar(_controller.ciskonto1.text, context).trim();
          if (indirim01.substring(indirim01.length - 2, indirim01.length)==".0")
            indirim01=indirim01.substring(0, indirim01.length-2);            

          if (_controller.secilenUrun.indirim01flag==1)  
            indirim01="%" + indirim01;

          String indirim02= _controller.setTutar(_controller.ciskonto2.text, context).trim();
          if (indirim02.substring(indirim02.length - 2, indirim02.length)==".0")
            indirim02=indirim02.substring(0, indirim02.length-2);
          if (_controller.secilenUrun.indirim02flag==1)  
            indirim02="%" + indirim02;

          String indirim03= _controller.setTutar(_controller.ciskonto3.text, context).trim();
          if (indirim03.substring(indirim03.length - 2, indirim03.length)==".0")
            indirim03=indirim03.substring(0, indirim03.length-2);

          if (_controller.secilenUrun.indirim03flag==1)
            indirim03="%" + indirim03;

          String indirim04= _controller.setTutar(_controller.ciskonto4.text, context).trim();
          if (indirim04.substring(indirim04.length - 2, indirim04.length)==".0")
            indirim04=indirim04.substring(0, indirim04.length-2);

          if (_controller.secilenUrun.indirim04flag==1)  
            indirim04="%" + indirim04 ;

          String indirim05= _controller.setTutar(_controller.ciskonto5.text, context).trim(); 
          if (indirim05.substring(indirim05.length - 2, indirim05.length)==".0")
            indirim05=indirim05.substring(0, indirim05.length-2);

          if (_controller.secilenUrun.indirim05flag==1)  
            indirim05="%" +indirim05;

          String indirim06= _controller.setTutar(_controller.ciskonto6.text, context).trim();
          if (indirim06.substring(indirim06.length - 2, indirim06.length)==".0")
            indirim06=indirim06.substring(0, indirim06.length-2);

          if (_controller.secilenUrun.indirim06flag==1)  
            indirim06="%" + indirim06;
            
          
          indirimler=indirim01 +";" + indirim02 +";" + indirim03 +";" + indirim04 +";" + indirim05 +";" + indirim06;

          //sirano++;
          SiparisSatir siparisSatir=
            SiparisSatir(
              rsayac: _controller.siparissatirrsayac.value,
              cid: 'JOT',              
              sirano:sirano,
              musrsayac:_controller.siparissayac.value,              
              //satirid: en sonunda  r_sayac ile güncellenecek.
              rtrg:-1,
              returnsayac:0,
              sevkplanino:0,
              irsaliyemiktari:0,
              masraf01:0,
              masraf02:0,
              masraf03:0,
              toplammasraf:0,
              masraflar:"0;0;0",
              miscellenousupdate:0,
              malzemersayac:0, 
              artanmiktar:0, 
              iademiktari:0, 
              sevkplanimiktari:0,
              toplamalistesiolustu :0,
              altbirimadedi:0,
              artantopsayisi:0,
              toplamalistesitopsayisi:0,
              kalantopsayisi:0,

              proformano:0,
              irsaliyersayac:0,
              malzemekodu:_controller.secilenUrun.malzemekodu,
              birimi:_controller.siparisBirimi.value,
              birimfiyat:double.parse(_controller.setTutar(_controller.cfiyat.text, context)),
              fiyattanimirsayac:0,
              sevkkalanmiktar:double.parse(_controller.setTutar(_controller.cmiktar.text, context)),
              miktar:double.parse(_controller.setTutar(_controller.cmiktar.text, context)),
              indirim:indirimler,
              asama:"1",
              sevktarihi:DateFormat('dd-MM-yyyy').parse(_controller.sevkTarihiController.text),
              teslimtarihi:DateFormat('dd-MM-yyyy').parse(_controller.sevkTarihiController.text),
              faturaedilenmiktar:0,
              bedelsiz:0,
              indirim01flag:_controller.secilenUrun.indirim01flag,
              indirim01:double.parse(_controller.setTutar(_controller.ciskonto1.text, context)), 
              indirim02flag:_controller.secilenUrun.indirim02flag,
              indirim02:double.parse(_controller.setTutar(_controller.ciskonto2.text, context)),
              indirim03flag:_controller.secilenUrun.indirim03flag,
              indirim03:double.parse(_controller.setTutar(_controller.ciskonto3.text, context)),
              indirim04flag:_controller.secilenUrun.indirim04flag,
              indirim04:double.parse(_controller.setTutar(_controller.ciskonto4.text, context)),
              indirim05flag:_controller.secilenUrun.indirim05flag,
              indirim05:double.parse(_controller.setTutar(_controller.ciskonto5.text, context)),
              indirim06flag:_controller.secilenUrun.indirim06flag,
              indirim06:double.parse(_controller.setTutar(_controller.ciskonto6.text, context)),
              toplamindirim:_controller.indirimTutari.value,
              stddovizkuru:1,
              dovizbirimfiyati:double.parse(_controller.setTutar(_controller.cfiyat.text, context)),
              doviztutar:_controller.tutar.value,
              dovizsatirtutari:_controller.toplamaTutar.value,
              dovizkdvmiktari:_controller.kdvTutari.value,
              satirtutari:_controller.toplamaTutar.value,
              sablonkodu:"0",
              kdvorani:_controller.secilenUrun.kdvorani,
              kdvtutari:_controller.kdvTutari.value,
              tutar:_controller.tutar.value,
              depono: satisTipi.depono,
              tesisno:satisTipi.tesisno,
              stoktipino:satisTipi.tesisno,              
              grupkodu:"", //kampanya grupkodu ve indirim kodu
              indirimkodu:"", //kampanya grupkodu ve indirim kodu
              kolibasikampanyaflag:0,
              bedelsizkampanyaflag:_controller.bedelsizkampanyaflag.value,
              yuzdeselkampanyaflag:_controller.yuzdeselkampanyaflag.value, //kampanya çalıması yapılınca ayarlancak.
              depozito:0,
              depozitoparentid:"",
              depozitosirano:0, 
              kolibasikosul:0,
              kolibasicarikod:"0",
              bedelsiztpr:_controller.bedelsizptr.value,
              bedelsizpaket:"", //kampanyadan gelen kolon
              aciklama:_controller.csatiraciklama.text              
            );

          if (_controller.siparissatirrsayac.value>0)
          {  
            siparisSatir.rsayac=_controller.siparissatirrsayac.value;
            siparisSatir.satirid=_controller.siparissatirrsayac.value;

            siparis.rsayac=_controller.siparissayac.value;
            await DBProvider.db.updateSiparisSatir(siparis, siparisSatir);
            
          }
          else
          {
            siparis.rsayac=_controller.siparissayac.value;
            await DBProvider.db.insertSiparisSatir(siparis, siparisSatir);           
          }
      }

      catch (e) 
      {
        print(e.toString());        
        snackbar("Uyarı", e.toString(), Icons.person);
        return false;
      }

      return true;
    
  }
  


  Future<bool> siparisIndirimKaydet(int rowNum) async {
    final SiparisController _controller =Get.put(SiparisController());

    await Future.forEach(_controller.siparisIndirim, (SiparisIndirim siparisIndirim) async               
    {
      if (siparisIndirim.sirano==rowNum)
      {
        if (!await DBProvider.db.insertSiparisIndirim(siparisIndirim))
        {
          return false;
        }
      }
        

    });

    return true;

  }


}