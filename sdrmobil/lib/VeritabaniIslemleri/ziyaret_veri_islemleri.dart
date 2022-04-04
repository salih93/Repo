
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdrmobil/components/get_snackbar.dart';
import 'package:sdrmobil/controller/controller.dart';
import 'package:sdrmobil/controller/tahsilat_controller.dart';
import 'package:sdrmobil/models/Satis/rut_listesi.dart';
import 'package:sdrmobil/models/Ziyaret/ziyaret.dart';
import 'package:sdrmobil/providers/db_provider.dart';

class ZiyaretVeriIslemleri {
  Future<bool> ziyaretBaslat() async {
    Controller _controller = Get.find();
    String uyariMesaji="";

      if (_controller.temsilcikodu.value == "" || _controller.temsilcikodu.value == null) {
        uyariMesaji="Temsilci bulunamadı, sisteme yeniden giriş yapmalısınız.";
        snackbar("Uyarı", uyariMesaji, Icons.person);
        return false;
      }
      if (_controller.carikod.value == "" || _controller.carikod.value == null) {
        uyariMesaji="Ziyaret başlatılmamış,önce ziyaret başlatmalısnız.";
        snackbar("Uyarı", uyariMesaji, Icons.person);
        return false;
      }

      int ziyarettipisayac=await DBProvider.db.getZiyaretSayac("Ziyaret Rut İçi", "Ziyaret Rut Dışı", _controller.rutdetaysayac.value);

      try 
      {       
        int uzakSiparis=_controller.uzaksiparis.value==null ? 0:_controller.uzaksiparis.value;
        if (uzakSiparis==0)
        {
          uzakSiparis=_controller.musteriKarti.value==null ? 0:_controller.musteriKarti.value;
        }

        Ziyaret ziyaret=
          Ziyaret(
            carikodu: _controller.carikod.value,
            startdate: DateTime.now(),
            startlatitude: _controller.currentlatitude.value,
            startlongitude: _controller.currentlongitude.value,
            rutdetaysayac: _controller.rutdetaysayac.value,
            rutdetaygun: _controller.rutdetaygun.value,
            faturatoplam: _controller.faturatoplam.value,
            siparistoplam: _controller.siparistoplam.value,
            tahsilattoplam: _controller.tahsilattoplam.value,
            ziyaretsonlandirmatipisayac: 0,
            ziyarettipisayac: ziyarettipisayac,
            isziyaretactive: 1,
            uzaksiparis: _controller.uzaksiparis.value==null ? 0:_controller.uzaksiparis.value,
          );

          if (_controller.uzaksiparis.value==1 || _controller.musteriKarti.value==1)
          {            
            ziyaret.isziyaretactive=0;
          }
          int ziyaretId=await DBProvider.db.insertZiyaret(ziyaret);
          if (_controller.uzaksiparis.value==1 || _controller.musteriKarti.value==1) 
            _controller.setUzakIslemZiyaretId(ziyaretId);
          else
            _controller.setZiyaretId(ziyaretId);            
      }
      
      catch (e) 
      {
        print(e.toString());        
        snackbar("Uyarı", e.toString(), Icons.person);
        return false;
      }

      return true;
    
  }

  Future<bool> ziyaretSonlandir() async {
    Controller _controller = Get.find();
    final TahsilatController tcontroller = Get.find();
    String uyariMesaji="";

      if (_controller.temsilcikodu.value == "" || _controller.temsilcikodu.value == null) {
        uyariMesaji="Temsilci bulunmadı, sisteme yeniden giriş yapmalısınız.";
        snackbar("Uyarı", uyariMesaji, Icons.person);
        return false;
      }
      
      try 
      {
        Ziyaret ziyaret=await DBProvider.db.getActivateZiyaretId();
        if (ziyaret.rutdetaysayac>0)
        {
          List<RutListesi> rutdetay = await DBProvider.db.getGunRutListesi();
          rutdetay.where((item) => item.rutDetaySayac==ziyaret.rutdetaysayac).forEach((element) {
            _controller.faturatoplam.value=element.gunlukFaturaTutar;
            _controller.siparistoplam.value=element.gunlukSiparisTutar;
            _controller.tahsilattoplam.value=element.gunlukTahsilatTutar;
          });
        }

        if (ziyaret!=null)
        {
          ziyaret.endlatitude=_controller.currentlatitude.value;
          ziyaret.endlongitude=_controller.currentlongitude.value;
          ziyaret.isziyaretactive=0;
          ziyaret.enddate=DateTime.now();
          ziyaret.aciklama=tcontroller.aciklamaZController.text;
          ziyaret.ziyaretsonlandirmatipisayac=tcontroller.ziyaretSonlandirmaTipiSayac.value;
          ziyaret.faturatoplam= _controller.faturatoplam.value;
          ziyaret.siparistoplam= _controller.siparistoplam.value;
          ziyaret.tahsilattoplam= _controller.tahsilattoplam.value;

          await DBProvider.db.updateZiyaret(ziyaret);
        }          
        _controller.setZiyaretId(0);

      } 
      catch (e) 
      {        
        print(e.toString());
        snackbar("Uyarı", e.toString(), Icons.person);
        return false;
      }

      return true;
  }


}