import 'dart:convert';

List<RutListesi> rutlistFromJson(String str) =>
    List<RutListesi>.from(json.decode(str).map((x) => RutListesi.fromJson(x)));

String rutlistToJson(List<RutListesi> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RutListesi {
  String kod;
  String unvan;
  String gun;
  int aktif;
  int gunsira;
  int rutsirano;
  double tlBorc;
  double tlAlacak;
  double tlAbakiye;
  double tlBbakiye;
  double calisilanBorc;
  double calisilanAlacak;
  double calisilanAbakiye;
  double calisilanBbakiye;
  double gunlukSiparisTutar;
  double gunlukFaturaTutar;
  double gunlukTahsilatTutar;
  bool isExpanded;
  String enlem;
  String boylam;
  int rutDetaySayac;
  int ziyaretSayisi;

  RutListesi({
    this.kod,
    this.unvan,
    this.gun,
    this.aktif,
    this.gunsira,
    this.rutsirano,
    this.tlBorc,
    this.tlAlacak,
    this.tlAbakiye,
    this.tlBbakiye,
    this.calisilanBorc,
    this.calisilanAlacak,
    this.calisilanAbakiye,
    this.calisilanBbakiye,
    this.gunlukSiparisTutar,
    this.gunlukFaturaTutar,
    this.gunlukTahsilatTutar,
    this.isExpanded,
    this.enlem,
    this.boylam,
    this.rutDetaySayac,
    this.ziyaretSayisi
  });

  factory RutListesi.fromJson(Map<String, dynamic> json) => RutListesi(
        kod: json["kod"],
        unvan: json["unvan"],
        gun: json["gun"],
        aktif: json["aktif"],
        gunsira: json["gun_sira"],
        rutsirano: json["rut_sira_no"],
        tlBorc: json['tl_borc'],
        tlAlacak: json['tl_alacak'],
        tlAbakiye: json['tl_abakiye'],
        tlBbakiye: json['tl_bbakiye'],
        calisilanBorc: json['calisilan_borc'],
        calisilanAlacak: json['calisilan_alacak'],
        calisilanAbakiye: json['calisilan_abakiye'],
        calisilanBbakiye: json['calisilan_bbakiye'],
        gunlukSiparisTutar: json['gunlukSiparisTutar'],
        gunlukFaturaTutar: json['gunlukFaturaTutar'],
        gunlukTahsilatTutar: json['gunlukTahsilatTutar'],
        isExpanded: json['isExpanded'],
        enlem: json['enlem'],
        boylam: json['boylam'],
        rutDetaySayac: json['rutDetaySayac'],
        ziyaretSayisi: json['ziyaret_sayisi']==null ? 0 : json['ziyaret_sayisi']
      );

  Map<String, dynamic> toJson() => {
        "kod": kod,
        "unvan": unvan,
        "gun": gun,
        "aktif": aktif,
        "gun_sira": gunsira,
        "rut_sira_no": rutsirano,
        "tl_borc": tlBorc,
        "tl_alacak": tlAlacak,
        "tl_abakiye": tlAbakiye,
        "tl_bbakiye": tlBbakiye,
        "calisilan_borc": calisilanBorc,
        "calisilan_alacak": calisilanAlacak,
        "calisilan_abakiye": calisilanAbakiye,
        "calisilan_bbakiye": calisilanBbakiye,
        "gunlukSiparisTutar": gunlukSiparisTutar,
        "gunlukFaturaTutar": gunlukFaturaTutar,
        "gunlukTahsilatTutar": gunlukTahsilatTutar,
        "isExpanded": isExpanded,
        'enlem':enlem,
        "boylam":boylam,
        "rutDetaySayac":rutDetaySayac
      };

}
