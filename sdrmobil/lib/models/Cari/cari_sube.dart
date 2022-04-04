import 'dart:convert';

List<CariSube> carisubeFromJson(String str) =>
    List<CariSube>.from(json.decode(str).map((x) => CariSube.fromJson(x)));

String carisubeToJson(List<CariSube> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CariSube {
  int rSayac;
  int cariSayac;
  String subeKodu;
  String subeAdi;

  CariSube({this.rSayac, this.cariSayac, this.subeKodu, this.subeAdi});

  factory CariSube.fromJson(Map<String, dynamic> json) => CariSube(
        rSayac: json["r_sayac"],
        cariSayac: json["cari_sayac"],
        subeKodu: json["sube_kodu"],
        subeAdi: json["sube_adi"],
      );

  Map<String, dynamic> toJson() => {
        "r_sayac": rSayac,
        "cari_sayac": cariSayac,
        "sube_kodu": subeKodu,
        "sube_adi": subeAdi,
      };
}
