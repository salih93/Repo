import 'dart:convert';

import 'package:get/get.dart';
import 'package:sdrmobil/controller/controller.dart';

List<CariAylikSatis> aylikSatisFromJson(String str) =>
    List<CariAylikSatis>.from(
        json.decode(str).map((x) => CariAylikSatis.fromJson(x)));

String aylikSatisToJson(List<CariAylikSatis> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CariAylikSatis {
  Controller _controller = Get.find();
  int id;
  String ayStr;
  String malzemeKodu;
  String malzemeAdi;
  String birim;
  String distStokKodu;
  String malzemesinifiadi;
  String malzemesinifiid;
  String path;
  int ay;
  double ciro;
  double miktar;
  String carikodu;

  CariAylikSatis(
      {this.id,
      this.ayStr,
      this.malzemeKodu,
      this.malzemeAdi,
      this.birim,
      this.distStokKodu,
      this.malzemesinifiadi,
      this.malzemesinifiid,
      this.path,
      this.ay,
      this.ciro,
      this.miktar,
      this.carikodu});

  CariAylikSatis.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ayStr = json['ay_str'];
    malzemeKodu = json['malzeme_kodu'];
    malzemeAdi = json['malzeme_adi'];
    birim = json['birim'];
    distStokKodu = json['dist_stok_kodu'];
    malzemesinifiadi=json['malzeme_sinifi_adi'];
    malzemesinifiid=json['malzeme_sinifi_id'];
    path=json['path'];
    ay = json['ay'];
    ciro = json['ciro'];
    miktar = json['miktar'];  
    carikodu=json['cari_kodu']!=null ? json['cari_kodu']:_controller.carikod.value;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ay_str'] = this.ayStr;
    data['malzeme_kodu'] = this.malzemeKodu;
    data['malzeme_adi'] = this.malzemeAdi;
    data['birim'] = this.birim;    
    data['dist_stok_kodu'] = this.distStokKodu;
    data['malzeme_sinifi_adi']=this.malzemesinifiadi;
    data['malzeme_sinifi_id']=this.malzemesinifiid;
    data['path']=this.path;
    data['ay'] = this.ay;
    data['ciro'] = this.ciro;
    data['miktar'] = this.miktar;
    data['cari_kodu']=this.carikodu;
    return data;
  }
}
