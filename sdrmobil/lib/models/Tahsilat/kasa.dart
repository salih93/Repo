import 'dart:convert';

List<Kasa> kasaFromJson(String str) =>
    List<Kasa>.from(json.decode(str).map((x) => Kasa.fromJson(x)));

String kasaToJson(List<Kasa> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Kasa {
  String kod;
  String sorumlu;
  int kredikartikasasi;

  Kasa({
    this.kod,
    this.sorumlu,
    this.kredikartikasasi
  });

  factory Kasa.fromJson(Map<String, dynamic> json) => Kasa(
        kod: json["kod"],
        sorumlu: json["sorumlu"],
        kredikartikasasi:json["kredi_karti_kasasi"],
      );

  Map<String, dynamic> toJson() => {
        "kod": kod,
        "sorumlu": sorumlu,
        "kredi_karti_kasasi":kredikartikasasi
      };
}
