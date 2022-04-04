import 'dart:convert';

List<MusteriMalAnaliziAy> musteriMalAnaliziAy(String str) =>
    List<MusteriMalAnaliziAy>.from(
        json.decode(str).map((x) => MusteriMalAnaliziAy.fromJson(x)));

String musteriMalAnaliziAyToJson(List<MusteriMalAnaliziAy> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


List<String> months = [
      'Ocak',
      'Şubat',
      'Mart',
      'Nisan',
      'Mayıs',
      'Haziran',
      'Temmuz',
      'Ağustos',
      'Eylül',
      'Ekim',
      'Kasım',
      'Aralık'];


class MusteriMalAnaliziAy {
  String musteriKodu;
  String malzemeKodu;
  String malzemeAdi;
  String unvan;
  double netMiktar;
  double netTutar;
  String ay;

  MusteriMalAnaliziAy({
    this.ay,
    this.musteriKodu,
    this.unvan,
    this.malzemeKodu,
    this.malzemeAdi,
    this.netMiktar,
    this.netTutar
  });

  MusteriMalAnaliziAy.fromJson(Map<String, dynamic> json) {
    musteriKodu = json['musteri_kodu'];
    unvan = json['unvan'];
    malzemeKodu = json['malzeme_kodu'];
    malzemeAdi = json['malzeme_adi'];
    netMiktar= json['net_miktar'];
    netTutar= json['net_tutar'];
    ay= json['ay']==null ?  months[0]:months[json['ay']-1];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['musteri_kodu'] = this.musteriKodu;
    data['unvan'] = this.unvan;
    data['malzeme_kodu'] = this.malzemeKodu;
    data['malzeme_adi'] = this.malzemeAdi;    
    data['net_miktar'] = this.netMiktar;
    data['net_tutar'] = this.netTutar;

    return data;
  }


}



