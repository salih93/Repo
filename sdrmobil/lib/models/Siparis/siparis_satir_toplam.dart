import 'dart:convert';

List<SiparisSatirToplam> siparisSatirToplamFromJson(String str) =>
    List<SiparisSatirToplam>.from(
        json.decode(str).map((x) => SiparisSatirToplam.fromJson(x)));

String siparisSatirToplamToJson(List<SiparisSatirToplam> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SiparisSatirToplam {
  int musrsayac;
  double tutar;
  double indirimTutari;
  double kdvTutari;
  double toplamaTutar;
  int sirano;
  String satistipi;

 SiparisSatirToplam(
      {      
      this.musrsayac,
      this.tutar,
      this.indirimTutari,
      this.kdvTutari,
      this.toplamaTutar,
      this.sirano,
      this.satistipi
      });

  SiparisSatirToplam.fromJson(Map<String, dynamic> json) {    
    musrsayac = json['mus_rsayac'];
    tutar=json['tutar'];
    indirimTutari=json['indirim_tutari'];
    kdvTutari=json['toplam_kdv'];
    toplamaTutar=json['toplam_tutar'];
    sirano=json['sira_no'];
    satistipi=json['satis_tipi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mus_rsayac']=musrsayac;
    data['tutar']=tutar;
    data['indirim_tutari']=indirimTutari;
    data['toplam_kdv']=kdvTutari;
    data['toplam_tutar']=toplamaTutar;
    data['sira_no']=sirano;
    data['satis_tipi']=satistipi;
    return data;
  }

}
