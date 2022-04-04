import 'dart:convert';

import 'package:intl/intl.dart';

List<Tahsilat> tahsilatFromJson(String str) =>
    List<Tahsilat>.from(
        json.decode(str).map((x) => Tahsilat.fromJson(x)));

String tahsilatToJson(List<Tahsilat> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Tahsilat {
  int rsayac;
  String cid;
  String temsilcikodu;
  String carikodu;
  DateTime tarih;
  String kasa;
  double fiyat;
  String fistur;
  String mutno;
  String mutno2;
  String mutno3;
  String slipno;
  String kartno;
  int androidgpssayac;
  String aciklama;
  String unvan;

 Tahsilat(
      {      
      this.rsayac,
      this.cid,
      this.temsilcikodu,
      this.carikodu,
      this.tarih,
      this.kasa,
      this.fiyat,
      this.fistur,
      this.mutno,
      this.mutno2,
      this.mutno3,
      this.slipno,
      this.kartno,
      this.androidgpssayac,
      this.aciklama,
      this.unvan
      });

  Tahsilat.fromJson(Map<String, dynamic> json) {    
    rsayac = json['r_sayac'];
    cid = json['cid'];
    temsilcikodu = json['temsilci_kodu'];
    carikodu = json['cari_kodu'];    
    tarih = json['tarih'] == null ? null : DateTime.parse(json['tarih']);
    kasa = json['kasa'];
    fiyat= json['fiyat'];
    fistur=json['fis_tur'];
    mutno=json['mut_no'];
    mutno2 = json['mut_no2'];
    mutno3 = json['mut_no3'];
    slipno = json['slipno'];    
    kartno = json['kartno'].toString();
    androidgpssayac=json['android_gps_sayac'];
    aciklama=json['aciklama'];
    unvan=json['unvan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['r_sayac'] = this.rsayac;
    data['cid'] = this.cid;
    data['temsilci_kodu'] = this.temsilcikodu;
    data['cari_kodu'] = this.carikodu;
    data['tarih'] = DateFormat('yyyy-MM-dd 00:00:00.000').format(this.tarih);
        
    data['kasa'] = this.kasa;
    data['fiyat']=(this.fiyat==null) ? 0 : this.fiyat;
    data['fis_tur']=this.fistur;
    data['mut_no']=this.mutno;
    data['mut_no2']=this.mutno2;
    data['mut_no3']=this.mutno3;
    data['slipno']=this.slipno;    
    data['kartno']=this.kartno;
    data['android_gps_sayac']=this.androidgpssayac;
    data['aciklama']=this.aciklama;
    return data;
  }

  Map<String, dynamic> toJsonUpdate() {
    final Map<String, dynamic> data = new Map<String, dynamic>();    
    data['cid'] = this.cid;
    data['temsilci_kodu'] = this.temsilcikodu;
    data['cari_kodu'] = this.carikodu;
    data['tarih'] = DateFormat('yyyy-MM-dd 00:00:00.000').format(this.tarih);
        
    data['kasa'] = this.kasa;
    data['fiyat']=(this.fiyat==null) ? 0 : this.fiyat;
    data['fis_tur']=this.fistur;
    data['mut_no']=this.mutno;
    data['mut_no2']=this.mutno2;
    data['mut_no3']=this.mutno3;
    data['slipno']=this.slipno;    
    data['kartno']=this.kartno;
    data['android_gps_sayac']=this.androidgpssayac;
    data['aciklama']=this.aciklama;
    return data;
  }

}
