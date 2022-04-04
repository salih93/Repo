import 'dart:convert';

List<Tanimlar> tanimlarFromJson(String str) =>
    List<Tanimlar>.from(json.decode(str).map((x) => Tanimlar.fromJson(x)));

String tanimlarToJson(List<Tanimlar> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Tanimlar {
  String key;
  String value;
  String groupname;

  Tanimlar({
    this.key,
    this.value,
    this.groupname,
  });

  factory Tanimlar.fromJson(Map<String, dynamic> json) => Tanimlar(
        key: json["key"],
        value: json["value"],
        groupname: json["groupname"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "value": value,
        "groupname": groupname,
      };

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["key"] = key;
    map["value"] = value;
    map["groupname"] = groupname;
    return map;
  }
}
