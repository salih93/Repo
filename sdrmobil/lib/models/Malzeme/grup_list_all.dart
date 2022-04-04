import 'dart:convert';
List<GrupListAll> grupListAllFromJson(String str) =>
    List<GrupListAll>.from(json.decode(str).map((x) => GrupListAll.fromJson(x)));

String grupListAllToJson(List<GrupListAll> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GrupListAll{
  String grupadi1;
  String grupadi2; 
  String grupadi3;

  GrupListAll({
    this.grupadi1,
    this.grupadi2,
    this.grupadi3   
  });

  GrupListAll.fromJson(Map<String, dynamic> json) {    
      this.grupadi1=json["grup_adi1"];
      this.grupadi2=json["grup_adi2"];
      this.grupadi3=json["grup_adi3"];
  }
  
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
        data['grup_adi1']=this.grupadi1;
        data['grup_adi2']=this.grupadi2;
        data['grup_adi3']=this.grupadi3;
        
    return data;
  }
      
}
