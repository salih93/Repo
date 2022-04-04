import 'dart:convert';

List<ZiyaretTipleri> ziyaretTipleriFromJson(String str) =>
    List<ZiyaretTipleri>.from(
        json.decode(str).map((x) => ZiyaretTipleri.fromJson(x)));

String ziyaretTipleriToJson(List<ZiyaretTipleri> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ZiyaretTipleri {
  int rsayac;  
  String tipi;
  String aciklama;

 ZiyaretTipleri(
      {
        this.rsayac,
        this.tipi,
        this.aciklama
      });

  ZiyaretTipleri.fromJson(Map<String, dynamic> json) {
    rsayac = json['r_sayac'];    
    tipi = json['tipi'];
    aciklama = json['aciklama'];    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['r_sayac']=rsayac;    
    data['tipi'] = this.tipi;
    data['aciklama'] = this.aciklama;

    return data;
  }
}
