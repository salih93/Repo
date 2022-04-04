import 'dart:convert';

List<SatisGrupToplam> satisGrupToplamFromJson(String str) =>
    List<SatisGrupToplam>.from(
        json.decode(str).map((x) => SatisGrupToplam.fromJson(x)));

String satisGrupToplamToJson(List<SatisGrupToplam> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SatisGrupToplam {
  String grupkodu;  
  double miktar;
  double gruptoplammiktar;
  double bedelsizgruptoplammiktar;
  int kampanyaRsayac;
  int iskontohanesi;
  String kampanyaadi;
  String grupAdi;
 SatisGrupToplam(
  {
    this.grupkodu,        
    this.miktar,
    this.gruptoplammiktar,
    this.bedelsizgruptoplammiktar,
    this.kampanyaRsayac,
    this.iskontohanesi,
    this.kampanyaadi,
    this.grupAdi
  });

  SatisGrupToplam.fromJson(Map<String, dynamic> json) {    
    grupkodu=json['grup_kodu'];      
    miktar=json['miktar'];
    gruptoplammiktar = json['grup_toplam_miktar'];
    bedelsizgruptoplammiktar = json['bedelsiz_grup_toplam_miktar'];
    kampanyaRsayac=json['kampanya_rsayac'];    
    iskontohanesi=json['iskontohanesi']==null ? null:json['iskontohanesi'];
    iskontohanesi=json['kampanya_adi']==null ? null:json['kampanya_adi'];
    grupAdi=json['grup_adi'] == null ? "" : json['grup_adi'];    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['grup_kodu']=grupkodu;    
    data['miktar']=miktar;
    data['grup_toplam_miktar']=gruptoplammiktar;
    data['bedelsiz_grup_toplam_miktar']=bedelsizgruptoplammiktar;
    data['kampanya_rsayac']=kampanyaRsayac;
    data['iskontohanesi']= iskontohanesi==null ? 0:iskontohanesi;
    data['kampanya_adi']= kampanyaadi==null ? "":kampanyaadi;
    
    
    return data;
  }

  

}