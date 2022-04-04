import 'dart:convert';

List<ZiyaretSonlandirmaTipleri> ziyaretSonlandirmaTipleriFromJson(String str) =>
    List<ZiyaretSonlandirmaTipleri>.from(
        json.decode(str).map((x) => ZiyaretSonlandirmaTipleri.fromJson(x)));

String ziyaretSonlandirmaTipleriToJson(List<ZiyaretSonlandirmaTipleri> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ZiyaretSonlandirmaTipleri {
  int rsayac;  
  String tipi;
  String aciklama;
  int sira;
  int sabit;
  int auto;
  int satisvar;
  int zorunluaciklama;

 ZiyaretSonlandirmaTipleri(
      {
        this.rsayac,
        this.tipi,
        this.aciklama,
        this.sira,
        this.sabit,
        this.auto,
        this.satisvar,
        this.zorunluaciklama        
      });

  ZiyaretSonlandirmaTipleri.fromJson(Map<String, dynamic> json) {
    rsayac = json['r_sayac'];    
    tipi = json['tipi'];
    aciklama = json['aciklama'];
    sira = json['sira'];
    sabit = json['sabit'];
    auto=json['auto'];
    satisvar=json['satisvar'];
    zorunluaciklama=json['zorunlu_aciklama'];    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['r_sayac']=rsayac;    
    data['tipi'] = this.tipi;
    data['aciklama'] = this.aciklama;
    data['sira'] = this.sira;
    data['sabit'] = this.sabit;
    data['auto'] = this.auto;
    data['satisvar'] = this.satisvar;
    data['zorunlu_aciklama'] = this.zorunluaciklama;

    return data;
  }
}
