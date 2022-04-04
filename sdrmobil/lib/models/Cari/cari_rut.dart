import 'dart:convert';

List<CariRut> userFromJson(String str) =>
    List<CariRut>.from(json.decode(str).map((x) => CariRut.fromJson(x)));

String userToJson(List<CariRut> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CariRut {
  String kod;
  String gun;
  int aktif;
  int gunsira;
  int rutsirano;
  int aktifnoktasayisi;
  int pasifnoktasayisi;
  int rutSayac;
  int rutDetaySayac;
  int bugun;

  CariRut({
    this.kod,
    this.gun,
    this.aktif,
    this.gunsira,
    this.rutsirano,
    this.aktifnoktasayisi,
    this.pasifnoktasayisi,
    this.rutSayac,
    this.rutDetaySayac,
    this.bugun
  });

  factory CariRut.fromJson(Map<String, dynamic> json) => CariRut(
        kod: json["kod"],
        gun: json["gun"],
        aktif: json["aktif"],
        gunsira: json["gun_sira"],
        rutsirano: json["rut_sira_no"],
        aktifnoktasayisi: json["aktifnoktasayisi"],
        pasifnoktasayisi: json["pasifnoktasayisi"],
        rutSayac: json["rutSayac"],
        rutDetaySayac: json["rutDetaySayac"],
        bugun: json["bugun"]
      );

  Map<String, dynamic> toJson() => {
        "kod": kod,
        "gun": gun,
        "aktif": aktif,
        "gun_sira": gunsira,
        "rut_sira_no": rutsirano,
        "aktifnoktasayisi": aktifnoktasayisi,
        "pasifnoktasayisi": pasifnoktasayisi,
        "rutSayac":rutSayac,
        "rutDetaySayac": rutDetaySayac,
        "bugun":bugun
      };
}
