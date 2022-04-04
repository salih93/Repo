import 'dart:convert';

List<KasaKodValue> kasaKodValueFromJson(String str) =>
    List<KasaKodValue>.from(json.decode(str).map((x) => KasaKodValue.fromJson(x)));

String kasaKodValueToJson(List<KasaKodValue> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class KasaKodValue {
  String kod;
  String sorumlu; 

  KasaKodValue({
    this.kod,
    this.sorumlu    
  });

  factory KasaKodValue.fromJson(Map<String, dynamic> json) => KasaKodValue(
        kod: json["kod"],
        sorumlu: json["sorumlu"]        
      );

  Map<String, dynamic> toJson() => {
        "kod": kod,
        "sorumlu": sorumlu        
      };
}
