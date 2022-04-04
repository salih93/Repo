import 'dart:convert';

List<RutBazindaCari> rutBazindaCariFromJson(String str) =>
    List<RutBazindaCari>.from(json.decode(str).map((x) => RutBazindaCari.fromJson(x)));

String rutBazindaCariToJson(List<RutBazindaCari> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RutBazindaCari {
  String kod;
  String unvan;
  String gun;

  RutBazindaCari({
    this.kod,
    this.unvan,
    this.gun
  });

  factory RutBazindaCari.fromJson(Map<String, dynamic> json) => RutBazindaCari(
        kod: json["kod"],
        unvan: json["unvan"],
        gun:json["gun"],
      );

  Map<String, dynamic> toJson() => {
        "kod": kod,
        "unvan": unvan,
        "gun":gun
      };
}
