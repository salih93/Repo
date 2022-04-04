import 'dart:convert';

import 'package:intl/intl.dart';

List<AktarimDurumu> aktarimDurumuFromJson(String str) =>
    List<AktarimDurumu>.from(
        json.decode(str).map((x) => AktarimDurumu.fromJson(x)));

String aktarimDurumuToJson(List<AktarimDurumu> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AktarimDurumu {
  int rsayac;  
  DateTime aktarimtarihi;
  

 AktarimDurumu(
  {      
      this.rsayac,
      this.aktarimtarihi
  });

  AktarimDurumu.fromJson(Map<String, dynamic> json) {    
    rsayac = json['r_sayac'];
    aktarimtarihi=DateTime.parse(json['aktarim_tarihi']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['r_sayac'] = this.rsayac;    
    data['aktarim_tarihi'] = DateFormat('yyyy-MM-dd HH:mm:ss.000').format(this.aktarimtarihi);
    return data;
  }

  Map<String, dynamic> toJsonUpdate() {
    final Map<String, dynamic> data = new Map<String, dynamic>();    
    data['aktarim_tarihi'] = DateFormat('yyyy-MM-dd HH:mm:ss.000').format(this.aktarimtarihi);    
    return data;
  }

}
