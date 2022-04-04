import 'dart:convert';

List<CariHesapEkstresiToplam> cariHesapEkstresiToplamFromJson(String str) =>
    List<CariHesapEkstresiToplam>.from(
        json.decode(str).map((x) => CariHesapEkstresiToplam.fromJson(x)));

String cariHesapEkstresiToplamToJson(List<CariHesapEkstresiToplam> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CariHesapEkstresiToplam {  
  double toplamBorc;
  double toplamAlacak;  

  CariHesapEkstresiToplam(
      {this.toplamBorc, this.toplamAlacak});

  CariHesapEkstresiToplam.fromJson(Map<String, dynamic> json) {    
    toplamBorc = json['toplamBorc'];
    toplamAlacak = json['toplamAlacak'];    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['toplamBorc'] = this.toplamBorc;
    data['toplamAlacak'] = this.toplamAlacak;    
    return data;
  }
  
}
