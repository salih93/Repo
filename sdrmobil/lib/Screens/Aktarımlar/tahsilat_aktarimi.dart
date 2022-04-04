import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdrmobil/components/get_snackbar.dart';
import 'package:sdrmobil/constants.dart';
import 'package:sdrmobil/controller/controller.dart';
import 'package:sdrmobil/controller/tahsilat_controller.dart';
import 'package:sdrmobil/models/aktarim_parameter_model.dart';
import 'package:sdrmobil/models/Tahsilat/tahsilat.dart';
import 'package:sdrmobil/models/validation_response.dart';
import 'package:sdrmobil/models/Ziyaret/ziyaret.dart';
import 'package:sdrmobil/providers/db_provider.dart';
import 'package:sdrmobil/providers/table_api_provider.dart';

class TahsilatAktarimi {
  Future<bool> verileriAktar() async {
    Controller _anaController = Get.find();
    final TahsilatController _controller = Get.put(TahsilatController());

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

      List<Tahsilat> tahsilatlar=await _controller.getAllTahsilat();
      List<Ziyaret> ziyaretler=await _controller.getAllZiyaret();
      if (ziyaretler.length>0 && tahsilatlar.length>0)     
      {
          _anaController.isLoading.value=true;
          _anaController.update();

          List<String> values=<String>[];
          var _model=jsonEncode(model.toJson());
          var _tahsilatlar=jsonEncode(tahsilatlar.map((i) => i.toJson()).toList());
          var _ziyaretler=jsonEncode(ziyaretler.map((e) => e.toJson()).toList());

          values.add(_model);
          values.add(_tahsilatlar);
          values.add(_ziyaretler);
          
          
          var aPiProvider = TableApiProvider(url, temsilci, veritabani, null);
          vr=await aPiProvider.setTahsilat(values);
          if (!vr.successful)
          {
            _anaController.isLoading.value=false;
            _anaController.update();
            //snackbar("Uyarı", 'Tahsilatlar aktarılamadı.'+vr.information, Icons.person);
            return false;
          }

          vr=await DBProvider.db.deleteAllTahsilat();
          if (!vr.successful)
          {
            _anaController.isLoading.value=false;
            _anaController.update();
            snackbar("Uyarı", 'Tahsilatlar silinemedi.'+vr.information, Icons.person);
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