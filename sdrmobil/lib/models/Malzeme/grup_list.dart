import 'dart:convert';

List<GrupList> grupAdiFromJson(String str) =>
    List<GrupList>.from(json.decode(str).map((x) => GrupList.fromJson(x)));

String grupAdiToJson(List<GrupList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GrupList{
  String grupadi1;
  String grupadi2; 

  GrupList({
    this.grupadi1,
    this.grupadi2    
  });

  GrupList.fromJson(Map<String, dynamic> json) {    
      this.grupadi1=json["grup_adi1"];
      this.grupadi2=json["grup_adi2"];
  }
  
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
        data['grup_adi1']=this.grupadi1;
        data['grup_adi2']=this.grupadi2;
    return data;
  }
      
}
