import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdrmobil/components/get_snackbar.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/controller/controller.dart';
import 'package:sdrmobil/controller/siparis_controller.dart';
import 'package:sdrmobil/models/Siparis/siparis.dart';
import 'package:sdrmobil/models/Siparis/siparis_indrim.dart';
import 'package:sdrmobil/models/Siparis/siparis_satir.dart';
import 'package:sdrmobil/models/aktarim_parameter_model.dart';
import 'package:sdrmobil/models/validation_response.dart';
import 'package:sdrmobil/models/Ziyaret/ziyaret.dart';
import 'package:sdrmobil/providers/db_provider.dart';
import 'package:sdrmobil/providers/table_api_provider.dart';

class SiparisAktarimi {
  Future<bool> verileriAktar() async {
    Controller _anaController = Get.find();
    final SiparisController _controller = Get.put(SiparisController());

    ValidationResponse vr= ValidationResponse(successful: true, information: "");

    String url = _anaController.firmaurl.value;
    String temsilci = _anaController.temsilcikodu.value;
    String veritabani = _anaController.veritabaniadi.value;
    
    try {

      AktarimParameterModel model=AktarimParameterModel();    
      model.temsilcikodu=_anaController.temsilcikodu.value;
      model.userid=_anaController.temsilcikodu.value;
      model.androidversiyon=kUygulamaVersiyonu;
      model.veritabaniadi=_anaController.veritabaniadi.value;
      model.token=_anaController.token.value;
      model.email=_anaController.email.value;
      
      
      List<Siparis> siparisler=await _controller.getAktarilacakSiparis();
      List<SiparisSatir> siparisSatir=await _controller.getAktarilacakSiparisSatir();
      List<SiparisIndirim> siparisIndirim=await _controller.getAllSiparisIndirim();
      if (siparisIndirim.length>0 && siparisSatir.length>0)
      {
        siparisSatir.forEach((element) { 
          if (siparisIndirim.where((item) => item.siparissatirrsayac==element.rsayac).length>0)
          {
            SiparisIndirim indirim=siparisIndirim.firstWhere((item) => item.siparissatirrsayac==element.rsayac);
            element.indirimkodu=indirim.indirimkodu;
            element.yuzdeselkampanyaflag=indirim.indirimtipi=="Y" ? 1:0;
            element.bedelsizkampanyaflag=indirim.indirimtipi=="B" ? 1:0;
            element.grupkodu=indirim.grupkodu;                        
          }
        });
      }


      List<Ziyaret> ziyaretler=await _controller.getAllZiyaret();
      if (ziyaretler.length>0 && siparisler.length>0)     
      {
          _anaController.isLoading.value=true;
          _anaController.update();

          List<String> values=<String>[];
          var _model=jsonEncode(model.toJson());
          var _siparisler=jsonEncode(siparisler.map((i) => i.toJson(1)).toList());
          var _siparissatir=jsonEncode(siparisSatir.map((i) => i.toJson()).toList());
          var _ziyaretler=jsonEncode(ziyaretler.map((e) => e.toJson()).toList());

          values.add(_model);
          values.add(_siparisler);
          values.add(_siparissatir);
          values.add(_ziyaretler);

          var aPiProvider = TableApiProvider(url, temsilci, veritabani, null);
          vr=await aPiProvider.setSiparis(values);
          if (!vr.successful)
          {
            _anaController.isLoading.value=false;
            _anaController.update();
            snackbar("Uyarı", 'Siparişler aktarılamadı.'+vr.information, Icons.person);
            return false;
          }

          vr=await DBProvider.db.deleteAllSiparisIndirim();
          if (!vr.successful)
          {
            _anaController.isLoading.value=false;
            _anaController.update();
            snackbar("Uyarı", 'Sipariş indirimler silinemedi.'+vr.information, Icons.person);
            return false;
          }

          vr=await DBProvider.db.deleteAllSiparisSatir();
          if (!vr.successful)
          {
            _anaController.isLoading.value=false;
            _anaController.update();
            snackbar("Uyarı", 'Sipariş indirimler silinemedi.'+vr.information, Icons.person);
            return false;
          }

          vr=await DBProvider.db.deleteAllSiparis();
          if (!vr.successful)
          {
            _anaController.isLoading.value=false;
            _anaController.update();
            snackbar("Uyarı", 'Sipariş indirimler silinemedi.'+vr.information, Icons.person);
            return false;
          }


          
      }      

    } 
    catch (e) {
      _anaController.isLoading.value=false;
      _anaController.update();
      snackbar("Uyarı", 'Veriler aktarılamadı.'+e.toString(), Icons.person);
      return false;
    }

    _anaController.isLoading.value=false;
    _anaController.update();
    return true;
  }
  
}