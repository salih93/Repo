
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdrmobil/components/get_snackbar.dart';
import 'package:sdrmobil/controller/controller.dart';
import 'package:sdrmobil/controller/tahsilat_controller.dart';
import 'package:sdrmobil/models/Tahsilat/tahsilat.dart';
import 'package:sdrmobil/providers/db_provider.dart';

class TahsilatVeriIslemleri {
  Future<bool> krediKartiKaydet() async {
    TahsilatController _controller = Get.find();
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

      if (_controller.fisturu.value == "" || _controller.fisturu.value == null) {
        uyariMesaji=uyariMesaji + "Fiş türü seçmelisiniz.";                
      }
      if (_controller.kasa.value == "" || _controller.kasa.value == null) {
        uyariMesaji=uyariMesaji + "Kasa seçmelisiniz.";                      
      }
      if (_controller.makbuzNoController.text == "" || _controller.makbuzNoController.text == null) {
        uyariMesaji=uyariMesaji + "Makbuz no girmelisiniz.";
      }
      if (_controller.tutarController.text == "" || _controller.tutarController.text == null) {
        uyariMesaji=uyariMesaji + "Tutar girmelisiniz.";                      
      }
      if (uyariMesaji!="")
      {
        snackbar("Uyarı", uyariMesaji, Icons.person);
        return false;
      }

      String tutar=_controller.tutarController.text.replaceAll(',', '.').trim();
      if (tutar.substring(tutar.length,tutar.length)==".")
        tutar=tutar + '0';


      try 
      {
        int ziyaretId=0;
        if (mainController.uzaksiparis.value==1)
          ziyaretId=mainController.uzakIslemziyaretId.value;
        else 
          ziyaretId=mainController.ziyaretId.value;
        
        Tahsilat tahsilat=
          Tahsilat(cid: 'JOT', 
            temsilcikodu: mainController.temsilcikodu.value,
            carikodu: mainController.carikod.value,
            fistur: _controller.fisturu.value,
            kasa: _controller.kasa.value,
            androidgpssayac: ziyaretId,
            aciklama: _controller.aciklamaController.text,
            fiyat:  double.parse(tutar),
            kartno: _controller.kKartNoController.text,
            mutno: _controller.makbuzNoController.text,
            slipno: _controller.slipNoController.text,
            tarih: DateTime.now(),
            mutno2: "",
            mutno3: ""
          );

          if (_controller.tahsilatsayac.value>0)
          {          
            tahsilat.rsayac=_controller.tahsilatsayac.value;  
            await DBProvider.db.updateTahsilat(tahsilat);
          }
          else
          {
            await DBProvider.db.insertTahsilat(tahsilat);
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
  
  Future<bool> tahsilatKaydet() async {
    TahsilatController _controller = Get.find();
    Controller mainController = Get.find();
    String uyariMesaji="";

      if (mainController.temsilcikodu.value == "" || mainController.temsilcikodu.value == null) {
        uyariMesaji="Temsilci bulunamadı, sisteme yeniden giriş yapmalısınız.";
        snackbar("Uyarı", uyariMesaji, Icons.person);
        return false;
      }
      if (mainController.carikod.value == "" || mainController.carikod.value == null) {
        uyariMesaji="Ziyaret başlatılmamış,önce ziyaret başlatmalısınız.";
        snackbar("Uyarı", uyariMesaji, Icons.person);
        return false;
      }

      if (_controller.fisturu.value == "" || _controller.fisturu.value == null) {
        uyariMesaji=uyariMesaji + "Fiş türü seçmelisiniz.";                
      }
      if (_controller.kasa.value == "" || _controller.kasa.value == null) {
        uyariMesaji=uyariMesaji + "Kasa seçmelisiniz.";                      
      }      
      if (_controller.tutarController.text == "" || _controller.tutarController.text == null) {
        uyariMesaji=uyariMesaji + "Tutar girmelisiniz.";                      
      }
      if (_controller.makbuzNoController.text == "" || _controller.makbuzNoController.text == null) {
        uyariMesaji=uyariMesaji + "Makbuz No girmelisiniz.";                      
      }

      if (uyariMesaji!="")
      {        
        snackbar("Uyarı", uyariMesaji, Icons.person);
        return false;
      }

      String tutar=_controller.tutarController.text.replaceAll(',', '.').trim();
      if (tutar.substring(tutar.length,tutar.length)==".")
        tutar=tutar + '0';

      try 
      {
        int ziyaretId=0;
        if (mainController.uzaksiparis.value==1)
          ziyaretId=mainController.uzakIslemziyaretId.value;
        else 
          ziyaretId=mainController.ziyaretId.value;
        
        Tahsilat tahsilat=Tahsilat(cid: 'JOT',
            temsilcikodu: mainController.temsilcikodu.value,
            carikodu: mainController.carikod.value,
            fistur: _controller.fisturu.value,
            kasa: _controller.kasa.value,
            androidgpssayac: ziyaretId,
            aciklama: _controller.aciklamaController.text,
            fiyat:  double.parse(tutar),
            kartno: "",
            mutno: _controller.makbuzNoController.text,
            slipno: "",
            tarih: DateTime.now(),
            mutno2: "",
            mutno3: ""
          );

        if (_controller.tahsilatsayac.value>0)
        {          
          tahsilat.rsayac=_controller.tahsilatsayac.value;  
          await DBProvider.db.updateTahsilat(tahsilat);
        }
        else
        {
          await DBProvider.db.insertTahsilat(tahsilat);
        }

      } 
      catch (e) 
      {        
        print(e.toString());
        snackbar("Uyarı", uyariMesaji, Icons.person);
        return false;
      }

      return true;

  }

}