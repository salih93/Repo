import 'dart:convert';

List<GrupAdi> grupAdiFromJson(String str) =>
    List<GrupAdi>.from(json.decode(str).map((x) => GrupAdi.fromJson(x)));

String grupAdiToJson(List<GrupAdi> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GrupAdi {
  String grupadi; 

  GrupAdi({
    this.grupadi    
  });

  factory GrupAdi.fromJson(Map<String, dynamic> json) => GrupAdi(
        grupadi: json["grupadi"]        
      );

  Map<String, dynamic> toJson() => {
        "grupadi": grupadi        
      };
      
}
