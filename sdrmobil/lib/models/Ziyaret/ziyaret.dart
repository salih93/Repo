import 'dart:convert';
import 'package:intl/intl.dart';

List<Ziyaret> ziyaretFromJson(String str) =>
    List<Ziyaret>.from(
        json.decode(str).map((x) => Ziyaret.fromJson(x)));

String ziyaretToJson(List<Ziyaret> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class Ziyaret {
  int id;
  DateTime startdate;
  DateTime enddate;
  double startlongitude;
  double startlatitude;
  double endlongitude;
  double endlatitude;
  String carikodu;
  int isziyaretactive;
  int rutdetaysayac;
  int rutdetaygun;
  double faturatoplam;
  double siparistoplam;
  double tahsilattoplam;
  int ziyarettipisayac;
  int ziyaretsonlandirmatipisayac;
  String aciklama;
  int uzaksiparis;

  Ziyaret({
    this.id,
    this.startdate,
    this.enddate,
    this.startlongitude,
    this.startlatitude,
    this.endlongitude,
    this.endlatitude,
    this.carikodu,
    this.isziyaretactive,
    this.rutdetaysayac,
    this.rutdetaygun,
    this.faturatoplam,
    this.siparistoplam,
    this.tahsilattoplam,
    this.ziyarettipisayac,
    this.ziyaretsonlandirmatipisayac,
    this.aciklama,
    this.uzaksiparis
  });

  Ziyaret.fromJson(Map<String, dynamic> json) {
    id = json['id'];    
    startdate = json['start_date'] == null ? null : DateTime.parse(json['start_date']);    
    enddate = json['end_date'] == null ? null : DateTime.parse(json['end_date']);
    startlongitude = json['start_longitude'];
    startlatitude = json['start_latitude'];
    endlongitude = json['end_longitude'];
    endlatitude = json['end_latitude'];
    carikodu=    json['cari_kodu'];
    isziyaretactive=json['is_ziyaret_active'];
    rutdetaysayac=json['rut_detay_sayac'];
    rutdetaygun=json['rut_detay_gun'];
    faturatoplam=json['fatura_toplam'];
    siparistoplam=json['siparis_toplam'];
    tahsilattoplam=json['tahsilat_toplam'];
    ziyarettipisayac=json['ziyaret_tipi_sayac'];
    ziyaretsonlandirmatipisayac=json['ziyaret_sonlandirma_tipi_sayac'];
    aciklama=json['aciklama'];
    uzaksiparis=json['uzak_siparis'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();    
    data['id']=this.id;
    data['start_date']=(this.startdate==null) ? null:DateFormat('yyyy-MM-dd HH:mm:ss').format(this.startdate);
    data['end_date']=(this.enddate==null) ? null:DateFormat('yyyy-MM-dd HH:mm:ss').format(this.enddate);    
    data['start_longitude'] = (this.startlongitude==null) ? 0 : this.startlongitude;
    data['start_latitude'] = (this.startlatitude==null) ? 0 : this.startlatitude;
    data['end_longitude'] = (this.endlongitude==null) ? 0 : this.endlongitude;
    data['end_latitude'] = (this.endlatitude==null) ? 0 : this.endlatitude;
    data['cari_kodu'] = this.carikodu;    
    data['is_ziyaret_active'] = this.isziyaretactive;
    data['rut_detay_sayac']=(this.rutdetaysayac==null) ? 0 : this.rutdetaysayac;
    data['rut_detay_gun']=(this.rutdetaygun==null) ? 0 : this.rutdetaygun;
    data['fatura_toplam']=this.faturatoplam;
    data['siparis_toplam']=this.siparistoplam;
    data['tahsilat_toplam']=this.tahsilattoplam;
    data['ziyaret_tipi_sayac']=(this.ziyarettipisayac==null) ? 0 : this.ziyarettipisayac;
    data['ziyaret_sonlandirma_tipi_sayac']=(this.ziyaretsonlandirmatipisayac==null) ? 0 : this.ziyaretsonlandirmatipisayac;
    data['aciklama']=(this.aciklama==null) ? "" : this.aciklama;
    data['uzak_siparis']=this.uzaksiparis==null ? 0:this.uzaksiparis;    
    return data;
  }

  Map<String, dynamic> toJsonUpdate() {
    final Map<String, dynamic> data = new Map<String, dynamic>();    
    data['start_date']=(this.startdate==null) ? null:DateFormat('yyyy-MM-dd HH:mm:ss').format(this.startdate);
    data['end_date']=(this.enddate==null) ? null:DateFormat('yyyy-MM-dd HH:mm:ss').format(this.enddate);    
    data['start_longitude'] = (this.startlongitude==null) ? 0 : this.startlongitude;
    data['start_latitude'] = (this.startlatitude==null) ? 0 : this.startlatitude;
    data['end_longitude'] = (this.endlongitude==null) ? 0 : this.endlongitude;
    data['end_latitude'] = (this.endlatitude==null) ? 0 : this.endlatitude;
    data['cari_kodu'] = this.carikodu;    
    data['is_ziyaret_active'] = this.isziyaretactive;
    data['rut_detay_sayac']=(this.rutdetaysayac==null) ? 0 : this.rutdetaysayac;
    data['rut_detay_gun']=(this.rutdetaygun==null) ? 0 : this.rutdetaygun;
    data['fatura_toplam']=this.faturatoplam;
    data['siparis_toplam']=this.siparistoplam;
    data['tahsilat_toplam']=this.tahsilattoplam;
    data['ziyaret_tipi_sayac']=(this.ziyarettipisayac==null) ? 0 : this.ziyarettipisayac;
    data['ziyaret_sonlandirma_tipi_sayac']=(this.ziyaretsonlandirmatipisayac==null) ? 0 : this.ziyaretsonlandirmatipisayac;
    data['aciklama']=(this.aciklama==null) ? "" : this.aciklama;
    data['uzak_siparis']=this.uzaksiparis==null ? 0:this.uzaksiparis;
    
    return data;
  }


}
